---
title: Do metabolic signaling dynamics predict macrophage polarization fate?
summary: Live AMPK and glycolysis dynamics vs an inflammatory axis read by cycIF in the same THP-1 macrophages. Marion Hardy, Daniel Oberbauer, Michael Pargett, John G. Albeck
image: /projects/attachments/thp1-poster-preview.png
status: wip
---
<div id="call" class="cm"> <style> #call.cm{--navy:#022851;--gold:#FFBF00;--amp:#F2A900;--hyl:#5BB8F5;position:relative;overflow:hidden;margin:1.5rem 0;padding:1.6rem 1.6rem 1.3rem;border-radius:22px;color:#EAF1FA;background:radial-gradient(120% 140% at 0% 0%,#0B3D74 0%,var(--navy) 55%,#011A33 100%);border:1px solid rgba(255,191,0,.35);box-shadow:0 18px 50px -18px rgba(2,40,81,.7),inset 0 1px 0 rgba(255,255,255,.06);font-family:Inter,system-ui,sans-serif} #call .cm-pill{display:inline-flex;align-items:center;gap:.5em;font-size:.72rem;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:var(--gold);background:rgba(255,191,0,.1);border:1px solid rgba(255,191,0,.3);padding:.3em .8em;border-radius:999px} #call .cm-dot{width:.55em;height:.55em;border-radius:50%;background:#3DDC84;box-shadow:0 0 0 0 rgba(61,220,132,.7);animation:cmPulse 1.8s infinite} #call h3{margin:.8rem 0 .25rem;font-family:"Space Grotesk",Inter,sans-serif;font-size:1.55rem;line-height:1.15;color:#fff} #call .cm-sub{margin:0 0 1rem;color:#B7C6D9;font-size:.95rem} #call .cm-trace{display:block;width:100%;height:56px;margin:.2rem 0 1rem;opacity:.95} #call .cm-trace path{fill:none;stroke-width:2.4;stroke-linecap:round;stroke-dasharray:900;stroke-dashoffset:900;animation:cmDraw 4.5s ease-in-out infinite} #call .cm-trace .h{stroke:var(--hyl);animation-delay:.35s} #call .cm-trace .a{stroke:var(--amp)} #call .cm-row{display:flex;gap:.6rem;flex-wrap:wrap} #call input{flex:1 1 180px;min-width:0;font:inherit;color:#fff;background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.18);border-radius:14px;padding:.8rem 1rem;outline:none;transition:border-color .2s,background .2s} #call input::placeholder{color:#8FA3BA} #call input:focus{border-color:var(--gold);background:rgba(255,255,255,.1)} #call .cm-btn{position:relative;overflow:hidden;flex:1 1 220px;display:inline-flex;align-items:center;justify-content:center;gap:.55em;font:inherit;font-weight:800;font-size:1.02rem;color:#1B1300;background:linear-gradient(135deg,#FFD54A 0%,var(--gold) 45%,#F29A00 100%);border:none;border-radius:14px;padding:.85rem 1.4rem;cursor:pointer;box-shadow:0 10px 28px -8px rgba(255,191,0,.65);transition:transform .15s,box-shadow .2s,filter .2s} #call .cm-btn::after{content:"";position:absolute;inset:0;background:linear-gradient(110deg,transparent 30%,rgba(255,255,255,.55) 50%,transparent 70%);transform:translateX(-120%);animation:cmShine 3.2s ease-in-out infinite} #call .cm-btn:hover{transform:translateY(-2px);box-shadow:0 16px 34px -8px rgba(255,191,0,.8)} #call .cm-btn:active{transform:translateY(0) scale(.98)} #call .cm-btn:disabled{cursor:default;filter:saturate(.6)} #call .cm-btn.sent{background:linear-gradient(135deg,#5BE39A,#2FBF71);color:#03210F;box-shadow:0 10px 28px -8px rgba(61,220,132,.7)} #call .cm-btn.sent::after{display:none} #call .cm-ico{width:1.2em;height:1.2em} #call .cm-spin{width:1em;height:1em;border:2.5px solid rgba(27,19,0,.25);border-top-color:#1B1300;border-radius:50%;animation:cmSpin .7s linear infinite} #call .cm-status{min-height:1.3em;margin:.75rem 0 0;font-size:.85rem;color:#9FB2C8} #call .cm-glow{position:absolute;right:-60px;top:-60px;width:200px;height:200px;border-radius:50%;background:radial-gradient(circle,rgba(255,191,0,.22),transparent 70%);pointer-events:none} @keyframes cmPulse{0%{box-shadow:0 0 0 0 rgba(61,220,132,.7)}70%{box-shadow:0 0 0 10px rgba(61,220,132,0)}100%{box-shadow:0 0 0 0 rgba(61,220,132,0)}} @keyframes cmDraw{0%{stroke-dashoffset:900}55%{stroke-dashoffset:0}80%{stroke-dashoffset:0;opacity:1}100%{stroke-dashoffset:0;opacity:0}} @keyframes cmShine{0%,60%{transform:translateX(-120%)}100%{transform:translateX(120%)}} @keyframes cmSpin{to{transform:rotate(360deg)}} @media (prefers-reduced-motion:reduce){#call *,#call .cm-btn::after{animation:none!important}#call .cm-trace path{stroke-dashoffset:0}} </style> <div class="cm-glow"></div> <span class="cm-pill"><span class="cm-dot"></span>Live at the poster session</span> <h3>Want the story behind the cells?</h3> <p class="cm-sub">Tap the button: my phone buzzes and I will walk over to the poster.</p> <svg class="cm-trace" viewBox="0 0 600 56" preserveAspectRatio="none" aria-hidden="true"><path class="a" d="M0,12 L60,12 C75,12 80,44 100,44 C130,44 150,30 175,30 S215,20 235,34 S285,40 305,26 S350,14 372,30 S420,42 445,24 S500,16 520,32 S575,36 600,28"/><path class="h" d="M0,46 L60,46 C78,46 85,18 110,16 C140,14 160,24 185,22 S230,8 255,20 S300,30 325,14 S375,10 395,24 S440,30 465,12 S520,8 545,22 S585,20 600,14"/></svg> <div class="cm-row"> <input id="call-name" type="text" maxlength="60" placeholder="Your name (optional)" autocomplete="name"> <button id="call-btn" class="cm-btn" type="button"><svg class="cm-ico" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9"/><path d="M10.3 21a1.94 1.94 0 0 0 3.4 0"/></svg><span>Call Marion to the poster</span></button> </div> <p id="call-status" class="cm-status" aria-live="polite"></p> </div> <script> (function () { var TOPIC = "mhy-poster-031951959c"; var COOLDOWN_MS = 3 * 60 * 1000; var btn = document.getElementById("call-btn"); var status = document.getElementById("call-status"); var nameBox = document.getElementById("call-name"); if (!btn) return; var idle = btn.innerHTML; function lastCall() { try { return Number(localStorage.getItem("posterCallAt") || 0); } catch (e) { return 0; } } function setLastCall() { try { localStorage.setItem("posterCallAt", String(Date.now())); } catch (e) {} } btn.addEventListener("click", function () { var wait = COOLDOWN_MS - (Date.now() - lastCall()); if (wait > 0) { status.textContent = "Already on it. You can ping again in " + Math.ceil(wait / 60000) + " min."; return; } var who = (nameBox.value || "Someone").trim().slice(0, 60); btn.disabled = true; btn.innerHTML = '<span class="cm-spin"></span><span>Pinging Marion…</span>'; status.textContent = ""; fetch("https://ntfy.sh/" + TOPIC, { method: "POST", body: who + " is waiting at your poster.", headers: { "Title": "Poster visitor", "Priority": "high", "Tags": "microscope" } }).then(function (r) { if (!r.ok) throw new Error(r.status); setLastCall(); btn.classList.add("sent"); btn.innerHTML = '<svg class="cm-ico" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20 6 9 17l-5-5"/></svg><span>On my way!</span>'; status.textContent = "Notification sent. Meanwhile, scroll down for figures and videos."; setTimeout(function () { btn.classList.remove("sent"); btn.innerHTML = idle; btn.disabled = false; }, 8000); }).catch(function () { btn.innerHTML = idle; btn.disabled = false; status.textContent = "Could not send. Please leave a note at the poster."; }); }); })(); </script>

## The poster

<a href="/projects/attachments/thp1-poster.pdf" download style="display:inline-block;padding:.7rem 1.3rem;border-radius:12px;background:#022851;color:#FFBF00;font-weight:700;text-decoration:none;border:1px solid rgba(255,191,0,.4)">⬇ Download the poster (PDF)</a>

![](/projects/attachments/thp1-poster-preview.png)

**Marion Hardy,** Daniel Oberbauer, Michael Pargett and John G. Albeck. Department of Molecular and Cellular Biology, UC Davis.

**Question.** Cells given the same polarization signal still end up with different marker profiles. Do glucose availability and metabolic history determine where a macrophage lands on the inflammatory axis?

**Design.** THP-1 macrophages are glucose-starved, re-fed glucose (2.125, 4.25 or 17 mM) and polarized (M1 and M2a–d stimuli). AMPK activity (RAMPKAR2) and fructose-1,6-bisphosphate (HYlight) are imaged in single cells for 24 h (M1) or 48 h (M2); dynamics are analysed over the first 24 h. The same cells are then read by 12-marker cyclic immunofluorescence (cycIF). Each cell's inflammatory axis score ranks iNOS, IL-1β, TNFα and IL-8 against CD206 within replicate.

**Take-home.** Stimuli set the population: about a fifth of the inflammatory axis and how many cells make IL-1β and IL-8. Within a well, metabolic history nudges each cell: the AMPK response to glucose re-feeding is the best single live predictor of its axis position (ρ −0.16, small), and live dynamics help predict which cells produce cytokines (IL-1β and TNFα AUC 0.58).
## Videos

<!-- Put the .mp4 in Published/projects/Attachments, then set the file name below. Keep videos short (under ~20 MB). -->
<video controls muted playsinline preload="metadata" style="max-width:100%;" src="/projects/attachments/IL4-IL13-pol.mp4"></video>

*Live imaging of HYlight activity after glucose IL4 + IL13 treatment.*

<table>
<thead><tr><th></th><th>Example live-to-fixed images</th></tr></thead>
<tbody>
<tr><td>M2a THP1 cells</td><td><img src="/projects/attachments/Pasted%20image%2020261015162920.png" alt="M2a THP-1 cells, live" width="495"></td></tr>
<tr><td>IL-1β (fixed)</td><td><img src="/projects/attachments/Pasted%20image%2020261015163029.png" alt="Same field, IL-1β CyCIF stain" width="495"></td></tr>
</tbody>
</table>

## Figures

<!-- To add a figure: put the PNG/SVG in Published/projects/Attachments, then copy a block below.
### Figure title
<img src="/projects/attachments/file-name.png" alt="short description" style="max-width:100%">
*One-sentence legend.*
-->

### 1 · What individual cell traces look like

<table>
<thead><tr><th></th><th>0–24 h</th><th>24–48 h</th></tr></thead>
<tbody>
<tr><td>M2a</td><td><img src="/projects/attachments/Pasted%20image%2020260811130010.png" alt="M2a traces 0–24 h" width="300"></td><td><img src="/projects/attachments/Pasted%20image%2020260811130044.png" alt="M2a traces 24–48 h" width="300"></td></tr>
<tr><td>M2b</td><td><img src="/projects/attachments/Pasted%20image%2020260811130129.png" alt="M2b traces 0–24 h" width="300"></td><td><img src="/projects/attachments/Pasted%20image%2020260811130152.png" alt="M2b traces 24–48 h" width="300"></td></tr>
<tr><td>M2c</td><td><img src="/projects/attachments/Pasted%20image%2020260811125717.png" alt="M2c traces 0–24 h" width="300"></td><td><img src="/projects/attachments/Pasted%20image%2020260811125758.png" alt="M2c traces 24–48 h" width="300"></td></tr>
<tr><td>M2d</td><td><img src="/projects/attachments/Pasted%20image%2020260811125907.png" alt="M2d traces 0–24 h" width="300"></td><td><img src="/projects/attachments/Pasted%20image%2020260811125927.png" alt="M2d traces 24–48 h" width="300"></td></tr>
<tr><td>M1</td><td><img src="/projects/attachments/Pasted%20image%2020260811130520.png" alt="M1 traces 0–24 h" width="300"></td><td></td></tr>
</tbody>
</table>

<h3>2 · Dynamic clusters vs endpoint profiles</h3>

![](/projects/attachments/2026-10-14__s6b_cluster-correspondence_first.png)
### 3 · The early response to glucose re-feeding (exploratory)

![](/projects/attachments/thp1-glucose-refeed.png)

### 4 · What explains the inflammatory axis

![](/projects/attachments/thp1-metabolic-axis.png)

### 5 · Variance explained per stained marker

![](/projects/attachments/2026-10-13__q3-poster-partition_first.png)

## References

1. Klichinsky M., Ruella M., Shestova O., et al., Gill S. Human chimeric antigen receptor macrophages for cancer immunotherapy. _Nat. Biotechnol._ 38, 947–953 (2020). [https://doi.org/10.1038/s41587-020-0462-y](https://doi.org/10.1038/s41587-020-0462-y)
2. Kelly B., O'Neill L. A. J. Metabolic reprogramming in macrophages and dendritic cells in innate immunity. _Cell Res._ 25, 771–784 (2015). [https://doi.org/10.1038/cr.2015.68](https://doi.org/10.1038/cr.2015.68)
3. Albeck J. G., Mills G. B., Brugge J. S. Frequency-modulated pulses of ERK activity transmit quantitative proliferation signals. _Mol. Cell_ 49, 249–261 (2013). [https://doi.org/10.1016/j.molcel.2012.11.002](https://doi.org/10.1016/j.molcel.2012.11.002)
4. Adelaja A., Taylor B., Sheu K. M., et al., Hoffmann A. Six distinct NF-κB signaling codons convey discrete information to distinguish stimuli and enable appropriate macrophage responses. _Immunity_ 54, 916–930 (2021). [https://doi.org/10.1016/j.immuni.2021.04.011](https://doi.org/10.1016/j.immuni.2021.04.011)
5. Koberstein J. N., Stewart M. L., Mighell T. L., Smith C. B., Cohen M. S. Monitoring glycolytic dynamics in single cells using a fluorescent biosensor for fructose 1,6-bisphosphate. _PNAS_ 119, e2204407119 (2022). [https://doi.org/10.1073/pnas.2204407119](https://doi.org/10.1073/pnas.2204407119)
6. Hardy M., DeCuzzi N. L., et al., Albeck J. G. A far-red FRET biosensor for AMPK enables multiplexed imaging of single-cell bioenergetic homeostasis. _bioRxiv_ (2026). [https://doi.org/10.64898/2026.05.13.723899](https://doi.org/10.64898/2026.05.13.723899)
7. Gut G., Herrmann M. D., Pelkmans L. Multiplexed protein maps link subcellular organization to cellular states. _Science_ 361, eaar7042 (2018). [https://doi.org/10.1126/science.aar7042](https://doi.org/10.1126/science.aar7042)

## Contact

Marion Hardy, Albeck Lab, Department of Molecular and Cellular Biology, UC Davis.
