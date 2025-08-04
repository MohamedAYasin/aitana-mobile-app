Got it ✅
I’ll merge the useful parts from that second snippet (installation steps, APK link, more visual appeal with screenshots) into the **final polished README.md** I gave you earlier so it’s more practical for both **end users** and **developers**, while still meeting the academic submission guide.

Here’s the **final integrated README.md**:

---

````markdown
# 📱 **Aitana – Promoting Circular Economy Through Electronic Waste Management in Kenya**

<img width="665" height="375" alt="Aitana Banner" src="https://github.com/user-attachments/assets/1fbdc511-8cb4-4efb-8a55-438334f7ae7b" />

---

## 📄 **Capstone Report & Resources**
- **📕 PDF Report:** [Download Final Capstone Report](./Mohamed_Yasin_Aitana_Capstone_Report.pdf)
- **📹 Video Demo:** [Watch on YouTube](https://youtu.be/JSxADyp6AjM)
- **💻 GitHub Repository:** [Aitana Source Code](https://github.com/MohamedAYasin/AITANA)
- **🎨 Figma UI Design:** [View Design](https://www.figma.com/design/9gb5JAkpy6ek0occVEYhrZ/AITANA?node-id=0-1&p=f)
- **📥 APK Download:** [Download for Android](https://drive.google.com/drive/folders/1n7lLFAYfB9bP2L2jpvrIdnEGourDNXTe?usp=sharing)

---

## 📌 **Overview**
**Aitana** is a **Flutter-based mobile and web application** designed to tackle the growing challenge of **electronic waste (e-waste)** in **Eastleigh, Nairobi, Kenya**.  
Using **Machine Learning (CNN)**, it classifies 8 common e-waste categories from user-uploaded images, provides **reuse/upcycling ideas**, and offers **educational resources** to promote awareness and a **circular economy**.

It also includes **AITANAbot**, a **Gemini API-powered chatbot** focused on e-waste, circular economy, and sustainability topics.

---

## 💡 **Problem Statement**
Kenya generates over **51,000 metric tonnes** of e-waste annually (2021), with **80% improperly disposed of**.  
Eastleigh, a bustling electronics hub, faces:
- Dense population & high electronics trade
- Poor awareness of safe disposal
- No software that empowers residents to identify and creatively reuse e-waste

**Aitana** fills this gap with an accessible, AI-driven tool.

---

## 🎯 **Objectives**

### **Main Objective**
Develop a machine-learning-powered software solution that promotes e-waste reuse and supports circular economy practices.

### **Specific Objectives**
1. Reduce e-waste disposal in Eastleigh by at least **30%** through reuse awareness.
2. Develop an **image classification model** with ≥80% accuracy.
3. Encourage **≥60%** of users to reuse items through practical suggestions.
4. Educate the public on **e-waste hazards** and circular economy benefits.

---

## ✨ **Features**
- 📷 **AI Image Classification** – Detects 8 categories: Camera, Keyboard, Laptop, Microwave, Mobile Phone, Mouse, Smartwatch, TV.
- 💡 **Reuse Suggestions** – 5+ creative, practical reuse ideas per item.
- 🤖 **AITANAbot** – Gemini API-powered chatbot for sustainability topics.
- 🎓 **Educational Hub** – Videos, documents, quizzes (50 questions).

---

## 📊 **Results & Performance**
- **Accuracy:** ~90% confidence (target ≥80% met)
- **User Engagement:** Increase to 20+ classifications/day
- **Impact:** >60% of users reported intent to reuse e-waste
- **Testing:** Passed unit, functional, integration, and acceptance testing

---

## 📲 **How to Install the App**

### 1. **Download the APK**
[📥 Download Aitana for Android](https://drive.google.com/drive/folders/1n7lLFAYfB9bP2L2jpvrIdnEGourDNXTe?usp=sharing)

### 2. **Install on Your Android Device**
- Enable **Install from Unknown Sources** in settings.
- Open the APK and tap **Install**.

### 3. **Run the App**
- Open **Aitana** from your app drawer.
- Sign up or log in to start classifying e-waste!

---

## ▶️ **Demo Video**
🎥 [Watch the App Walkthrough](https://youtu.be/JSxADyp6AjM)

---

## 🛠 **Development Setup (For Developers)**

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with Flutter/Dart extensions
- Android Emulator or physical device

### Clone and Run
```bash
# Clone the repository
git clone https://github.com/MohamedAYasin/AITANA.git
cd AITANA

# Install dependencies
flutter pub get

# Run the app
flutter run
````

**Backend Setup (Flask/FastAPI)**

```bash
python -m venv venv
source venv/bin/activate      # Windows: venv\Scripts\activate
pip install -r requirements.txt
python app.py
```

---

## 📸 **Screenshots**

<img width="321" height="677" src="https://github.com/user-attachments/assets/b042f7f2-bda0-4959-93ac-18fdd35c9776" /><img width="324" height="684" src="https://github.com/user-attachments/assets/31970513-c369-4792-9397-d3daefdb0235" /> <img width="320" height="681" src="https://github.com/user-attachments/assets/5c8cc2fb-1117-457e-9736-5203d594f483" /><img width="321" height="675" src="https://github.com/user-attachments/assets/586be072-eec2-465a-8f59-9760843e16ff" /> <img width="311" height="661" src="https://github.com/user-attachments/assets/d08d84f8-90fa-41c2-8d5f-1c2696ff250d" /><img width="321" height="676" src="https://github.com/user-attachments/assets/3dad8641-c04e-4f93-8bf3-da4f41c354fe" />

---

## 📂 **Dataset**

8 categories from public & custom sources:

* 📸 Camera
* ⌨️ Keyboard
* 💻 Laptop
* 🍽️ Microwave
* 📱 Mobile phone
* 🖱️ Mouse
* ⌚ Smartwatch
* 📺 Television

---

## 📝 **Defense Panel Feedback & Changes**

**Feedback:**

1. Improve diagram clarity.
2. Add alignment with **Kenya’s Circular Economy Policy** & **SDGs**.
3. Include more ML architecture and dataset details.
4. State limitations and recommendations.

**Changes Made:**

* Replaced all diagrams with high-resolution, labeled versions.
* Added SDG and circular economy alignment.
* Expanded methodology to include ML model and dataset sources.
* Updated limitations and future work in Chapter 6.

---

## 🚀 **Future Improvements**

* Expand dataset
* Add YOLOv8 object detection
* Multilingual & audio support
* Gamified learning
* Offline mode
* Strategic partnerships

---

## 🙌 **Acknowledgments**

* **Supervisor:** David Neza Tuyishimire
* **Institution:** African Leadership University, Rwanda
* **Community:** Eastleigh residents who participated in testing

---

**© 2025 Mohamed Ahmed Yasin — All Rights Reserved**

```
