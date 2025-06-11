# **Deploying Apache Web Server on AWS EC2 using Terraform**

## **Table of Contents**
1. **Introduction**
2. **Prerequisites**
3. **Step-by-Step Implementation**
   - **Step 1: Set Up Terraform**
   - **Step 2: Configure AWS Credentials**
   - **Step 3: Initialize & Apply Terraform**
   - **Step 4: Verify Resources in AWS Console**
   - **Step 5: Test the Web Server**
4. **Cleanup (Destroy Resources)**
5. **Conclusion**

---

## **1. Introduction**
This guide walks you through deploying an **Apache Web Server** on an **Amazon EC2** instance using **Terraform**. The setup includes:
- Launching an **Amazon Linux 2023** instance.
- Installing and configuring **Apache (httpd)** via **User Data**.
- Automating deployment with **Terraform**.
- Testing the web server via its public IP.

---

## **2. Prerequisites**
✅ **AWS Account** (Free Tier eligible)  
✅ **AWS CLI Configured** (`aws configure`)  
✅ **Terraform Installed** (`terraform --version`)  
✅ **Existing Key Pair** (for SSH access, if needed)  
✅ **Existing Security Group** (with HTTP/80 & SSH/22 inbound rules)  

---

## **3. Step-by-Step Implementation**

### **Step 1: Set Up Terraform**
1. Create a new directory for the project:
   ```bash
   mkdir apache-terraform && cd apache-terraform
   ```

### **Step 2: Configure AWS Credentials**
Ensure AWS CLI is configured:
```bash
aws configure
```
Enter:
- **AWS Access Key ID**
- **AWS Secret Access Key**
- **Default Region (`us-east-1` or your choice)**
- **Default Output Format (`json`)**

---


### **Step 3: Initialize & Apply Terraform**
1. **Initialize Terraform** (downloads AWS provider):
   ```bash
   terraform init
   ```
 (![image](https://github.com/user-attachments/assets/cc7cf109-2545-44ac-9fd1-9884be602f36)


2. **Review the execution plan**:
   ```bash
   terraform plan
   ```
  ![image](https://github.com/user-attachments/assets/c8a60e49-c56b-4b8c-a1bf-301257b044cb)


3. **Apply the configuration** (creates resources):
   ```bash
   terraform apply 
   ```
   ![image](https://github.com/user-attachments/assets/27d002ce-bfeb-4d20-9ef3-f7f2898ef63d)


  ![image](https://github.com/user-attachments/assets/d6e792ff-11a6-40f2-ad65-da3275fae8ca)






### **Step 4: Verify Resources in AWS Console**
1. **EC2 Dashboard**:
   - Check the instance is **running**.
   - Verify **Name Tag**: `Custom-Apache-Web-Server`.
   - Note the **Public IPv4 address**.
![image](https://github.com/user-attachments/assets/d0767d6f-377b-4dcf-8f4b-0d8a6bbd6e16)


2. **Security Group**:
   - Ensure **HTTP (80)** and **SSH (22)** are allowed.
![image](https://github.com/user-attachments/assets/d3fbee4c-661d-4b06-ad78-d38e41cb257d)
*

---

### **Step 5: Test the Web Server**
1. Copy the **Public IP** from Terraform outputs or AWS Console.
2. Open a browser and visit:


   ```
   http://<public_ip>
   ```
   
![image](https://github.com/user-attachments/assets/ae109e3e-699c-4e06-a40d-14ccb08c80c9)




## **4. Cleanup (Destroy Resources)**
To avoid unnecessary charges, destroy the infrastructure:
```bash
terraform destroy -auto-approve
```
![image](https://github.com/user-attachments/assets/e6f698c9-b762-4302-b8c5-98d9f923d90b)


![image](https://github.com/user-attachments/assets/9425dde6-d770-45e1-b58d-cb013a434cb2)


## **5. Conclusion**
✅ Successfully deployed an **Apache Web Server** on **AWS EC2** using **Terraform**!  
✅ Automated installation via **User Data**.  
✅ Verified access via **Public IP**.  


**🚀 Happy Hosting!** 🚀
