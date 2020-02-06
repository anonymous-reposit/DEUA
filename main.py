import os

# EUA dataset
os.system("python3.6 UC.py EUA")
os.system("python3.6 LD.py EUA")
os.system("python3.6 FuzzyControl.py EUA")
os.system("python3.6 FFD.py EUA")
os.system("python3.6 Random.py EUA")
os.system("python3.6 Threshold.py EUA")

# Telecom dataset
os.system("python3.6 UC.py Telecom")
os.system("python3.6 LD.py Telecom")
os.system("python3.6 FuzzyControl.py Telecom")
os.system("python3.6 FFD.py Telecom")
os.system("python3.6 Random.py Telecom")
os.system("python3.6 Threshold.py Telecom")