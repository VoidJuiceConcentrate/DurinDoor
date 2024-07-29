# Print an embedded linux image with Shinobi pre-installed
### PROJECT IS PRE-ALPHA: DO NOT USE. 
#### Please check back later. Will update when project generates first usable image. 

#### 2024-07-27

This project aims to streamline building quick-boot security camera enabled embedded linux images for embedded devices. Initial building done on amd64 and arm64, testing done against a Raspberry Pi Zero W. 

STAGES:

- Docker Boot: ✓
- Buildroot Make: ✓
   - Automate buildroot make: x
- Image gen: x
- Image Boot: x
    - Networking: x
    - Encryption (ssh/certs): x
    - Shinobi: x
    - Automation: x

# Install

1. Download this repository and enter it.
    - If you **do not have Docker** installed run `sh INSTALL/docker.sh`.
2. Review and modify the `docker-compose.yml` file.
    - Leave it as-is for default setup.
3. Run the preparation and starter script.
    ```
    bash setup_and_run.sh
    ```

#### Credits

This project uses code from the following sources: 

https://github.com/IronOxidizer/instant-pi/ (Various buildroot and boot config files used as skeletons)

https://gitlab.com/Shinobi-Systems/ShinobiDocker (Used as skeleton for project)

https://gitlab.com/buildroot.org/buildroot 

https://gitlab.com/Shinobi-Systems/Shinobi 

