# Print an embedded linux image with Shinobi pre-installed
### PROJECT IS PRE-ALPHA: DO NOT USE. 
#### Please check back later. Will update when project generates first usable image. 

#### 2024-07-27

This project aims to streamline building quick-boot security camera enabled embedded linux images for embedded devices. Initial building done on amd64 and arm64, testing done against a Raspberry Pi Zero W. 

It also tries to stay loosely within the core direction outlined in IronOxidizer/instant-pi:
- Buildroot for system builder
- musl for c libraries
- busybox / busybox init
- f2fs on rootfs

STAGES:

- Docker Boot: ✓
- Buildroot Make: ✓
   - Automate buildroot make: x
- Image gen: ✓
- Image Boot: ✓
    - raspicam/raspivid: x 
    - Networking(wireless): x
    - Encryption (ssh/certs): x
    - Shinobi: x
    - Automation: x
    - Hibernation: x

# Install

1. Download this repository and enter it.
    - If you **do not have Docker** installed run `sh INSTALL/docker.sh`.
2. Review and modify the `docker-compose.yml` file.
    - Leave it as-is for default setup.
3. Run the preparation and starter script.
    ```
    bash setup_and_run.sh
    ```
# Using the Printer

As it is right now, it's a pretty manual process. However, after completing the previous step:

   1. In a terminal window, do the following command to log into the new container
      ```
      docker exec {running-container-name} bash
      ```
   2. Ensure your current directory is /home/buildroot
   3. Buildroot very much dislikes running as root, so anything we do needs to respect the user "node" (Default user for this docker image). Run the following to set buildroot up to compile.
      ```
      su -c 'make linux_rpi0w_quickboot_defconfig' node
        ```
   4. That part is quick. The next part is not. Put on a kettle, get your favorite book ready, have a coffee pot on standby.
      ```
      su -c 'make' node
      ```
- It's worth noting here that buildroot's multithreading gating is pretty cromulent, sometimes I will do `make -j12` on a 16 core system so it doesn't lock up too bad.

5. This should spit out an image at /home/buildroot/output/image/sdcard.img. Plug that into your balena etcher, raspberry pi imager, `dd if= of=` if you're old school.

A folder was included for handing off files with the host (/home/buildrootOutput on the container, ~/buildrootOutput on the host). It's best to copy any files you need for installation or examination there before wiping the container for another build. 


#### Credits

This project uses code from the following sources: 

https://github.com/IronOxidizer/instant-pi/ (Various buildroot and boot config files used as skeletons)

https://gitlab.com/Shinobi-Systems/ShinobiDocker (Used as skeleton for project)

https://gitlab.com/buildroot.org/buildroot 

https://gitlab.com/Shinobi-Systems/Shinobi 

