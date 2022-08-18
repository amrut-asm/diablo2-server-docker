# diablo2-server-docker
One tap creation of a docker image containing all the necessary components required to run a Diablo 2 private server

## Warning: Currently, for some reason D2GS.exe uses 100 percent CPU. This was not the case for the images that I built manually. Will fix in some time.

Used to host a Diablo II server at [nanibot.net](https://nanibot.net)

The created docker image will have the following applications managed by Supervisor:
1. bnetd
2. d2cs
3. d2dbs
4. d2gs (Emulated using Wine)

# Prerequisites for building
1. Hashicorp Packer
2. Docker

# Prerequisites for running
1. Docker
2. Docker-compose (required on the machine which will host the server)

# Instructions
1. Modify the variables in `variables.auto.pkrvars.hcl`
2. Run `packer build .` to create the docker image. This step takes around 30 minutes on a decent quad-core. Build time is long because Wine is compiled from source.
3. Copy the contents under the `generated` folder to your VPS or to the location you want to host the server from.
4. Load the docker image from the tar file by using `sudo docker load -i <image-name>`
5. From the location containing the `data` folder and the `docker-compose.yml` file, run `sudo docker-compose up -d`

For a running server, the following log files will be present under `data/var/`:
1. bnetd.log
2. d2cs.log
3. d2dbs-gs.log
4. d2dbs.log
5. d2gs.log - This log file will be empty as d2gs logs directly to the folder where D2GS.exe is present (i.e. inside the docker container)

![Game Screenshot](https://user-images.githubusercontent.com/83200243/184547087-466c49aa-202f-46d1-bfaf-0809581c91ed.png)
