# Setting Up Kali Linux on VMware

## Step 1: Downloading Kali Linux ISO

To install Kali Linux, we first need the installation file (ISO).

1. Visit the [official Kali Linux website](https://www.kali.org/get-kali/)

![official page](assets/01_official_kali_websit.png)
 
2. Click on **Downloads**.
3. Choose the version that matches your system (usually 64-bit for modern computers).

![image 2](assets/02_installer_image.png)

4. Download the ISO file.

![download_ISO file](assets/03_download_Iso.png)

> 💡 **Tip:** After downloading, the file may be in `.7z` format. Use tools like **WinRAR** or **7-Zip** to extract it.

![save](assets/04_saveExplorerfile.png)
---

## Step 2: Creating a Virtual Machine in VMware

Let’s start VMware Workstation Pro to create a virtual machine for Kali Linux.

1. Open **VMware Workstation Pro**.
2. Right-click the VMware icon and select **Run as Administrator**.

![run as admin](assets/05_runasadmin.png)

3. Click **Create a New Virtual Machine**.

![createVM](assets/06_createNewVm.png)
4. In the setup wizard:
   - Choose **Typical (recommended)**.

![](assets/07_wizardNext.png)

   - Select **Installer disc image file (ISO)** and browse for the Kali Linux ISO.

![iso select](assets/08_isoSelect.png)

   - Choose **Linux** as the guest operating system.

![choose linux](assets/09_pickLinux.png)

   - Select **Other Linux 6.x kernel 64-bit** from the dropdown.

![](assets/10_otherLinux.png)  

5. Set a name for the virtual machine (e.g., `Kali_Linux`).
6. Choose a location for storing VM files (default is fine).

![set name](assets/11_nameVM.png)

7. Set the disk size to **at least 20 GB** and choose **Store virtual disk as a single file**.

![storing disk](assets/12_romStoreDisk.png)

---

## Step 3: Customizing Hardware Settings

Before completing the setup:

1. Click **Customize Hardware**.

![customization](assets/13_customize_hardware.png)

2. Set **Memory (RAM)**:
   - Minimum: 2 GB (2048 MB)
   - Recommended: 4 GB (4096 MB)
  
![setting rams](assets/15_setting_Ram.png)

3. Set **Processors**:
   - 2 processors and 2 cores per processor
  
![Processor](asset/16_SettingProcessor.png)

4. Set **Network Adapter**:
   - Choose **Custom: Specific virtual network**
   - Select VMnet with **NAT** to share the host’s IP address
  
![settingNetwork](assets/17_setting Network.png)

5. Click **Close**, then **Finish**.

![](assets/19_finish_Settings.png)

---

## Step 4: Installing Kali Linux

1. Start the virtual machine with **Play Virtual Machine**.

![](assets/20_poweronKali.png)

2. When prompted, select **Graphical Install**.

![](assets/21_PickGraphic_installer.png)

3. Follow the prompts:
   - Choose **language**, **location**, and **keyboard layout**
  
![](assets/22_chooseLang.png)

![](assets/23_selectLocation.png)

![](assets/24_SelectKeyboard.png)

   - Set a **hostname** (e.g., `kali`)

![](assets/26_configureNetwork_.png)

   - Leave **domain name** blank

![](assets/27_domain_name.png)

   - Create a **username** and **secure password**

![](assets/28_Password.png)

![](assets/29_username.png)

![](assets/30_usersandpassword.png)

   - Configure your **time zone**

![](assets/31_configureClock.png)

4. Partitioning:
   - Choose **Guided – use entire disk**
  
![](assets/32_diskpartition.png)

   - Select available virtual disk (e.g., `SCSI3 (0,0,0)`)

![](assets/33_select_diskPart.png)

   - Choose **All files in one partition**

![](assets/34_selectforpartitioning.png)

   - Finish partitioning and **write changes to disk**

![](assets/35_partitionDisks.png)


5. Confirm writing changes to disk (**Yes**).

![](assets/36_partition_table.png)

6. The base system will install (takes several minutes).

![](assets/37_installing_baseSystem.png)

7. Select additional software:
   - Choose **GNOME**
  
![](assets/38_Gnome.png)

   - Optionally include **Top 10 tools** or **default tools**

![](assets/39_selectInstalSoftware.png)

8. Configure **gdm3** (default for GNOME).

![](assets/40_configure_gdm.png)

![](assets/40_configure_gdm.png)

![](assets/41_installations.png)

9. Install **GRUB bootloader**:
   - Install on `/dev/sda`
  
![](assets/)

10. Finish installation:
    - Remove the installation ISO when prompted
    - Click **Continue** to reboot

---

## Step 5: Logging In

After reboot:

- Use the **username** and **password** you created during installation.

---

## Step 6: Updating Kali Linux

After first login:

```bash
sudo apt update && sudo apt upgrade -y
````

During update:

* Select **No** for package restart prompt
* Click **OK** to continue

---

## Step 7: Installing VMware Tools

To optimize performance:

```bash
sudo apt install open-vm-tools-desktop -y
```

> 💡 Might already be installed. If not, wait for installation.

Then restart the virtual machine.

---

## Step 8: Verifying the Setup

### 1. Check for Updates:

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Verify VMware Tools:

```bash
vmware-toolbox-cmd -v
```

### 3. Test Network:

```bash
ping -c 4 google.com
```

> ✅ If you receive replies, your internet is working correctly.

---

## Step 9: Installing VS Code

To install **Visual Studio Code** on Kali Linux:

👉 A detailed guide is available [here](https://code.visualstudio.com/docs/setup/linux) or install using terminal:

```bash
sudo apt install code -y
```

---

By following these steps, you've successfully installed and configured Kali Linux in VMware with essential tools and updates.

```

---

Let me know if you'd like this saved to a downloadable `.md` file.
```
