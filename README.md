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
