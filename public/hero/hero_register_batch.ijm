// ============================================================
//  hero_register_batch.ijm
//  Batch rigid registration to a common REF, DAPI-driven, tolerant
//  of DIFFERING channel counts across acquisitions.
//
//  Per acquisition (MOV): build a 2-frame multichannel stack where
//    frame1 = [REF_DAPI, MOV ch2..chN placeholder-free] is avoided;
//  instead:
//    frame1 channels = REF_DAPI duplicated to MOV's channel count,
//    frame2 channels = MOV's channels,
//    registration_channel = 1 (DAPI) drives the rigid transform,
//    applied to ALL channels of frame2. Then keep frame2.
//
//  This decouples from REF's own channel count: only REF's DAPI is
//  used, tiled to match MOV, so 3- and 5-channel files both work.
//
//  INPUT : folder of multi-channel TIFFs (ch1 = DAPI). First file = REF (its ch1 = ref DAPI).
//  OUTPUT: <inDir>/aligned/<name>  (registered MOV, original channel count)
// ============================================================

inDir  = getDirectory("Choose folder of multi-channel TIFFs (ch1=DAPI)");
outDir = inDir + "aligned" + File.separator;
if (!File.exists(outDir)) File.makeDirectory(outDir);
DAPI_CH = 1;

list = getFileList(inDir);
Array.sort(list);

// Fixed reference: cell-paint acquisition (DAPI = ch1 drives alignment).
refName = "2025-12-07_cell-paintxy1.tif";
if (!File.exists(inDir + refName)) exit("Reference not found: " + refName);

// Build REF_DAPI once (ch DAPI_CH of the reference file)
open(inDir + refName); rename("REF_SRC");
setSlice(DAPI_CH);
run("Duplicate...", "title=REF_DAPI");
selectWindow("REF_SRC"); close();

for (i=0;i<list.length;i++) {
    name = list[i];
    if (!isTiff(name)) continue;

    open(inDir + name); rename("MOV"); nMov = nSlices;

    // Tile REF_DAPI to nMov channels so frame1 matches frame2's channel count.
    // (Only the DAPI channel drives SIFT; other channels are copies, ignored by
    //  registration but needed so the hyperstack dims are consistent.)
    selectWindow("REF_DAPI");
    run("Duplicate...", "title=REFTILE duplicate range=1-1");
    for (c=2;c<=nMov;c++) {
        selectWindow("REF_DAPI");
        run("Duplicate...", "title=rd_"+c);
    }
    // Concatenate REF_DAPI copies into an nMov-slice frame1
    cmd = "  title=REFFRAME image1=REFTILE";
    for (c=2;c<=nMov;c++) cmd += " image"+c+"=rd_"+c;
    cmd += " image"+(nMov+1)+"=[-- None --]";
    run("Concatenate...", cmd);

    // Concatenate frame1 (REFFRAME) + frame2 (MOV) -> 2*nMov slices
    run("Concatenate...", "  title=COMBO image1=REFFRAME image2=MOV image3=[-- None --]");
    selectWindow("COMBO");
    got = nSlices;
    if (got != 2*nMov) {
        print("MISMATCH "+name+": COMBO="+got+" expected="+(2*nMov)+" (nMov="+nMov+")");
        closeAllExcept(newArray("REF_DAPI")); continue;
    }
    run("Stack to Hyperstack...", "order=xyczt(default) channels="+nMov+" slices=1 frames=2 display=Composite");

    // Rigid SIFT, DAPI (ch1) drives, applied to all channels of both frames.
    run("Linear Stack Alignment with SIFT MultiChannel",
        "registration_channel="+DAPI_CH+" " +
        "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 " +
        "feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 " +
        "maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");

    // Keep aligned frame2 (the MOV channels).
    run("Hyperstack to Stack");
    run("Make Substack...", "slices="+(nMov+1)+"-"+(nMov*2));
    saveAs("Tiff", outDir + name);

    closeAllExcept(newArray("REF_DAPI"));
}
if (isOpen("REF_DAPI")) { selectWindow("REF_DAPI"); close(); }
print("Done. Aligned -> " + outDir + "\nNext: hero_crop_export.ijm on this folder.");

function isTiff(f) { l=toLowerCase(f); return (endsWith(l,".tif")||endsWith(l,".tiff")); }
function closeAllExcept(keep) {
    t = getList("image.titles");
    for (k=0;k<t.length;k++) {
        drop=true;
        for (m=0;m<keep.length;m++) if (t[k]==keep[m]) drop=false;
        if (drop) { selectWindow(t[k]); close(); }
    }
}
