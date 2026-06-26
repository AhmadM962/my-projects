# LinkedIn Projects & Skills Guide

Ready-to-use content for your LinkedIn profile.
For full details on all projects, see: https://github.com/AhmadM962/my-projects

---

## How to Use This File

1. **Projects Section:** Copy each project's title, summary, and date into LinkedIn's "Projects" section (7 entries total: 5 top projects + 2 umbrella collections)
2. **Skills Section:** Use the consolidated skills list at the bottom to add to your LinkedIn skills
3. **Media:** You can upload your report files (.docx/.pdf) as media attachments on each project
4. **Link:** Add your GitHub repo link to each project so recruiters can explore further

---

## LinkedIn Projects (7 Entries: 5 Top Projects + 2 Collections)

---

### WHY THESE 5: These are the projects that will make a cybersecurity hiring manager stop scrolling. Each one demonstrates a different core competency that employers look for.

---

## Top 5 Projects

### 1. Penetration Testing & Exploit Development (HtuCrackers)
**Date:** 2025-2026 | **Associated with:** Al Hussein Technical University
**Project link:** https://github.com/AhmadM962/my-projects/tree/main/Penetration%20Testing

Developed a complete buffer overflow exploit from scratch across 7 phases: fuzzing a target service to crash at ~2011 bytes, identifying EIP offset at 2003 bytes, confirming control with 0x42424242, finding a JMP ESP gadget in essfunc.dll via mona.py, and delivering a reverse shell using MSFvenom shellcode. Pivoted from the compromised server to a secondary target through network tunneling. Also completed PortSwigger race condition labs, a TryHackMe Active Directory room, and 9 CyberTalents CTF challenges (easy through hard).

**Skills:** Penetration Testing, Exploit Development, Buffer Overflow, Python, Metasploit, Immunity Debugger, Kali Linux, Network Pivoting, CTF, Burp Suite

> **Why this matters:** Demonstrates end-to-end offensive security capability -- the #1 skill employers look for in a cybersecurity engineer.

---

### 2. Privacy-Preserving Phishing URL Detection (Research Paper)
**Date:** 2025-2026 | **Associated with:** Al Hussein Technical University
**Project link:** https://github.com/AhmadM962/my-projects/tree/main/Computing%20Research%20Project

Authored an academic research paper on a novel phishing detection system that runs entirely offline for user privacy. Trained an XGBoost classifier on the PhiUSIIL dataset using URL-only lexical features, achieving 99.93% accuracy with sub-0.1% miss and false-alarm rates at millisecond-range inference speed. Used SHAP for model explainability and conducted a user survey (n=33) showing 97% preference for inline browser warnings over pop-ups. Proposed a deployable browser extension concept combining lightweight ML with human-centered warning design.

**Skills:** Machine Learning, XGBoost, SHAP, Python, scikit-learn, Cybersecurity, Academic Research, Survey Design

> **Why this matters:** Combines ML engineering with security research -- shows you can do more than run tools, you can innovate.

---

### 3. Lock & Key - Cryptographic Communication System
**Date:** Summer 2025 | **Associated with:** Al Hussein Technical University
**Project link:** https://github.com/AhmadM962/my-projects/tree/main/Cryptography

Built a complete secure communication system from scratch in Python: full DES implementation (IP, FP, E, P permutations, 8 S-boxes, 16 subkeys, Feistel rounds) with CBC mode and Ciphertext Stealing -- passed all 34 professor test vectors (25 ECB + 9 CBC-CTS). Implemented RSA key generation, segmented digital signatures over SHA-256, and sign-then-encrypt workflow. Demonstrated RSA cryptanalysis on textbook RSA without padding and compared ECB vs CBC security on image encryption (ECB reveals patterns, CBC produces noise).

**Skills:** Python, Cryptography, DES, RSA, SHA-256, CBC Mode, Digital Signatures, Number Theory

> **Why this matters:** Building crypto from scratch proves deep understanding of how security works at the mathematical level -- rare and valued.

---

### 4. Digital Forensics - Data Leak Investigation
**Date:** 2025-2026 | **Associated with:** Al Hussein Technical University
**Project link:** https://github.com/AhmadM962/my-projects/tree/main/Forensics

Investigated a suspected data leak at a UK legal firm by analyzing a deliberately corrupted VHD disk image. Repaired two byte-level corruptions (MBR Starting LBA and VBR MFTMirr cluster reference), discovered a steganographically hidden DOCX contract embedded after a PNG IEND marker, and built a forensic timeline linking the suspect to data exfiltration through Prefetch analysis (HxD hex editor usage), LNK shortcuts (file accessed from external Z: drive), and USN Journal records (batch copy at 12:29:01 UTC). Applied UK Computer Misuse Act 1990 and ISO/IEC 27037 standards.

**Skills:** Digital Forensics, FTK Imager, HxD, Steganography Detection, NTFS Internals, MBR/VBR Analysis, Evidence Recovery, Incident Investigation

> **Why this matters:** DFIR (Digital Forensics & Incident Response) is one of the highest-demand cybersecurity specialties.

---

### 5. ShipTrack - Secure Package Delivery Application
**Date:** 2025-2026 | **Associated with:** Al Hussein Technical University
**Project link:** https://github.com/AhmadM962/my-projects/tree/main/Secure%20Coding

Developed a security-first Java 17 console application for a package delivery company with four user roles (Admin, Dispatcher, Customer, Delivery). Implemented PBKDF2-HMAC-SHA-256 password hashing (16-byte salt, 65,536 iterations, 256-bit key), role-based access control, configurable password policies, and account lockout. Created a full STRIDE threat model using Microsoft Threat Modeling Tool with 10+ threats per category. Validated with a 106-test JUnit suite, Jazzer fuzz testing (10,000 iterations, zero failures), and PMD static analysis (61 violations found and remediated).

**Skills:** Java, Secure Coding, PBKDF2, STRIDE Threat Modeling, JUnit Testing, Fuzz Testing, PMD Static Analysis, RBAC

> **Why this matters:** Secure development skills are critical -- this proves you can build software that's secure by design, not just find holes in others' code.

---

## Project Collections

### 6. Network & Cloud Security Portfolio (5 projects)
**Date:** 2024-2026 | **Associated with:** Al Hussein Technical University
**Project link:** https://github.com/AhmadM962/my-projects

A collection of 5 infrastructure security projects completed during my degree:

**Multi-Site Secure Network (Network Security):** Designed a 5-office network with IPSec VPN tunnels, Cisco ASA firewall with DMZ, ACLs, device hardening (SSH, port security, DHCP snooping), and AAA authentication.

**AWS Cloud Infrastructure (Cloud Computing):** Built two AWS solutions -- a cloud migration with multi-AZ VPC, Auto Scaling, IAM least-privilege, and S3 lifecycle policies; plus a serverless medical booking app using Lambda, API Gateway, DynamoDB, and Amplify CI/CD.

**Enterprise Network Design (Networking):** Deployed a 7-office network with VLSM subnetting, RIPv2, five services (DHCP, DNS, FTP, HTTP, Email), and security hardening.

**DPSR Penetration Test (Ethical Hacking):** OSINT reconnaissance (Shodan, theHarvester), Nmap scanning, Nessus vulnerability assessment, OWASP Top 10 web analysis.

**OS Administration (Operating Systems):** Linux user/group/permission management, Docker, process scheduling algorithms, and system hardening.

**Skills:** AWS, Cisco Packet Tracer, IPSec VPN, Cisco ASA, VPC, Lambda, DynamoDB, Nmap, Nessus, Linux Administration, Docker, Network Design, Firewall Configuration

---

### 7. Security Governance, Risk & Compliance Portfolio (5 projects)
**Date:** 2024-2026 | **Associated with:** Al Hussein Technical University
**Project link:** https://github.com/AhmadM962/my-projects

A collection of 5 GRC (Governance, Risk, Compliance) and supporting projects:

**Cyber Risk Assessment - SOES (Risk Analysis):** Complete risk assessment of a 6,000-user examination system using STRIDE/DREAD threat modeling, FAIR quantitative analysis with Annualized Loss Exposure, and NIST CSF mapping.

**ISMS Design (Information Security):** Designed an Information Security Management System for a multi-regional insurance company using COBIT 2019, ISO 27001, PDCA cycle, and audit planning.

**Corporate Security Assessment (Security):** 17-observation risk register, GDPR/HIPAA compliance analysis, three security policies (email, wireless, disaster recovery) using ISO 31000.

**AI Threat Detection Planning (Project Management):** Complete project plan for an AI-driven threat detection system at a real cybersecurity firm, including WBS, Gantt charts, and $30K budget management.

**AI/ML for Security (AI & Intelligent Systems):** Built ML pipelines (KNN: 91.98% accuracy) with Azure ML deployment and SHAP explainability, plus AI ethics analysis for healthcare with GDPR/HIPAA compliance.

**Skills:** STRIDE, DREAD, FAIR, NIST CSF, ISO 27001, COBIT 2019, ISO 31000, GDPR, HIPAA, Risk Assessment, Threat Modeling, Security Policy, Project Management, Machine Learning

---

## LinkedIn Skills List

Copy these skills to your LinkedIn profile's Skills section. They are ordered by relevance and frequency across your projects.

### Top Skills (add these first - most impactful)
1. Cybersecurity
2. Python
3. Java
4. Penetration Testing
5. Network Security
6. Cloud Computing (AWS)
7. Risk Assessment
8. Machine Learning
9. SQL / MySQL
10. Linux

### Technical Skills
11. Threat Modeling (STRIDE/DREAD)
12. Cryptography
13. Digital Forensics
14. Secure Coding
15. Vulnerability Assessment
16. Nmap
17. Metasploit
18. Nessus
19. Wireshark
20. Burp Suite
21. Cisco Packet Tracer
22. IPSec VPN
23. Firewall Configuration
24. Data Structures & Algorithms
25. Object-Oriented Programming
26. Azure ML
27. scikit-learn
28. XGBoost
29. SHAP
30. Power BI
31. Data Visualization
32. Git / GitHub
33. JUnit Testing
34. Docker
35. Serverless Architecture
36. API Development

### Frameworks & Standards
37. NIST Cybersecurity Framework
38. ISO 27001
39. COBIT 2019
40. ISO 31000
41. OWASP Top 10
42. FAIR Risk Model
43. GDPR
44. HIPAA

### Soft Skills
45. Project Management
46. Agile Methodology
47. Technical Writing
48. Academic Research
49. Problem Solving
50. Team Leadership

---

## LinkedIn Headline Suggestions

Pick one that fits your target role:

- `Cybersecurity Graduate | Penetration Testing, Cloud Security & Risk Analysis | HTU`
- `Cybersecurity Professional | Python, AWS, Ethical Hacking | BSc Computing - HTU`
- `Security-Focused Software Developer | Java, Python, AWS | Penetration Testing & Secure Coding`

---

## LinkedIn About Section Draft

Cybersecurity-focused computing graduate from Al Hussein Technical University with hands-on experience across 25 academic projects spanning penetration testing, cloud security (AWS), risk analysis, secure coding, digital forensics, and AI/ML.

Key highlights:
- Developed a full buffer overflow exploit from fuzzing through reverse shell with network pivoting
- Built and deployed ML pipelines on AWS (XGBoost phishing detector: 99.93% accuracy)
- Designed secure multi-site networks with IPSec VPN, ASA firewalls, and defense-in-depth
- Implemented DES and RSA cryptographic algorithms from scratch in Python
- Authored an academic research paper on privacy-preserving phishing URL detection
- Built secure Java applications with PBKDF2 authentication, 106 JUnit tests, and fuzz testing

Skilled in Python, Java, AWS, Metasploit, Nmap, Nessus, STRIDE/DREAD threat modeling, NIST CSF, ISO 27001, and COBIT 2019.

Open to opportunities in cybersecurity, penetration testing, cloud security, and security engineering.
