// ============================================================
//  hero_crop_export.ijm
//  Crop + per-slice LUT/B-C + one JPEG per channel.
//  Registration is done UPSTREAM (manual, in Fiji GUI) — this
//  macro assumes input stacks are already aligned to a common frame.
//
//  INPUT : folder of pre-registered multi-slice TIFFs (channels as
//          slices; up to 5). All share the crop frame.
//  OUTPUT: <outDir>/<filename>_slice<N>.jpg  (700x420 = Hero space)
// ============================================================

// ---- Config ----
inDir  = getDirectory("Choose folder of registered TIFF stacks");
outDir = "C:/Users/mhardy/Documents/mhy_website/public/hero/";
if (!File.exists(outDir)) File.makeDirectory(outDir);

X=444; Y=1066; W=700; H=420;       // crop rect (native px)
OUT_W=700; OUT_H=420;              // export size = Hero coord space
LUTS = newArray("Grays","Blue","Green","Red","Magenta","Cyan","Yellow","Fire");

list = getFileList(inDir);
Array.sort(list);

for (i=0;i<list.length;i++) {
    name = list[i];
    if (!isTiff(name)) continue;

    open(inDir + name);
    stackTitle = getTitle();

    // --- Crop to shared hero rect (applies to all slices) ---
    makeRectangle(X,Y,W,H);
    run("Crop");

    // --- Per-slice: LUT + B/C + export one JPEG per channel ---
    n = nSlices;
    for (s=1; s<=n; s++) {
        selectWindow(stackTitle);
        setSlice(s);

        // LUT choice for this channel
        Dialog.create("Colour: " + name + "  slice " + s + "/" + n);
        Dialog.addChoice("LUT:", LUTS, "Grays");
        Dialog.show();
        run(Dialog.getChoice());

        // B/C window opens each time
        run("Enhance Contrast", "saturated=0.35");
        run("Brightness/Contrast...");
        waitForUser("Adjust B/C (" + name + " slice " + s + ")",
            "Fine-tune Brightness/Contrast, then OK to export.");

        // Flatten current slice -> RGB -> resize -> JPEG
        run("Duplicate...", "title=EXP");
        selectWindow("EXP");
        run("RGB Color");
        run("Size...", "width="+OUT_W+" height="+OUT_H+" interpolation=Bilinear");
        saveAs("Jpeg", outDir + stripExt(name) + "_slice" + s + ".jpg");
        close();                    // EXP
    }
    selectWindow(stackTitle); close();
}
print("Done. Exported per-channel JPEGs -> " + outDir);

// ---- Helpers ----
function isTiff(f) { l=toLowerCase(f); return (endsWith(l,".tif")||endsWith(l,".tiff")); }
function stripExt(f) { return replace(f, "\\.tiff?$", ""); }
