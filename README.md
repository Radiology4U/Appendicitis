This repository accompanies the manuscript:

**From Bedside to Bot-Side: Artificial Intelligence in Emergency Appendicitis Management**  
Koray Ersahin*, Sebastian Sanduleanu*, Sithin Thulasi Seetha, Johannes Bremm, Cavid Abbasli, Chantal Zimmer, Tim Damer, Jonathan Kottlors, Lukas Goertz, Christiane Bruns, David Maintz, Nuran Abdul-layev  
*Shared first authorship

We evaluate **GPT-4.5**, **DeepSeek R1**, and a **Random Forest** classifier for recommending **appendectomy vs. conservative therapy** in patients with suspected acute appendicitis (AA).

---

## 📊 Study Overview

- **Cohorts:** 113 ED presentations (63 histopathologically confirmed AA, 50 controls)  
- **Sites:** GFO Kliniken Troisdorf, University Hospital Cologne (UKK)  
- **Design:** Retrospective, Oct 2022 – Oct 2023  
- **LLMs:** Zero-shot; with and without **RAG** (WSES 2020 Jerusalem guidelines)  
- **Reference standard:** Board-certified surgeon’s decision

**Headline results**

- DeepSeek: **80.5% → 83.2%** with RAG  
- GPT-4.5: **70.8% → 76.1%** with RAG  
- Random Forest: **83.3% (train)**, **87.0% (validation)**  
- McNemar: ML > DeepSeek (**p = 0.002**); DeepSeek ≈ GPT-4.5 (**p = 0.36**)

---

## 📈 What We Measure

- **Primary:** Accuracy vs. reference standard (appendectomy vs. conservative)  
- **Agreement:** Cohen’s κ (with interpretation bands)  
- **Between-model tests:** McNemar test (paired)  
- **ML performance:** ROC/AUC, confusion matrices (train/validation)

🧪 Statistical Notes
Cohen’s κ interpretation: 0.61–0.80 substantial; 0.81–1.00 almost perfect

Power for κ: target κ=0.8 vs. minimum κ=0.4, 50/50 classes, α=0.05, 80% power → n≈42

McNemar tests compare paired model decisions per patient

🔐 Ethics & Governance
IRB approval: 23–1061-retro (GFO Kliniken Troisdorf)

Retrospective; consent waived; no patient-identifying data supplied to AI

Data sharing: de-identified data on reasonable request to the corresponding author

🧰 Tech Stack
Python: Random Forest (scikit-learn), plotting (matplotlib)

R: Accuracy/κ/McNemar (caret, psych, irr), reproducible stats scripts

RAG source: WSES 2020 Jerusalem guidelines (for LLM “with RAG” condition)

⚠️ Limitations (per manuscript)
Retrospective design; incomplete exam/report fields in some cases

LLM guideline parsing limitations (e.g., flowchart comprehension)

No modeling of OR logistics, shared decision-making, or re-prompt variability

🧩 Citations (selected)
Di Saverio S, et al. WSES 2020: World J Emerg Surg. 2020;15:27.

Sanduleanu S, et al. GPT-3.5 vs ML (appendicitis): AI 2024;5(4):1942-1954.

TRIPOD+AI statement: BMJ. 2024;385:e078378.
