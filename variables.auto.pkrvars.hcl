# Network that docker-compose will create
# NOTE: Make sure no network with the same CIDR exists
NETWORK_CIDR          =  "172.18.0.0/16"

# Internal IP that should be assigned to the docker container
INTERNAL_IP           =  "172.18.0.101"

# External IP of the machine where the docker container is running on
# NOTE: If this is same as the INTERNAL_IP defined above, then the server
#       will __NOT__ be reachable over the internet.
EXTERNAL_IP           =  ""

# Max Games that D2GS can host
# NOTE: The following variable must have 8 characters in total
#       i.e. for 16 games the value should be "00000016"
D2GS_MAXGAMES         =  "00000008"

# Hash of the password to be used for D2GS telnet access
# Generate a hash from this link: https://pvpgn.pro/passhash/?do=hash 
TELNET_PASSWORD_HASH  =  ""

# Password for D2CS <---> D2GS communication (plaintext)
D2CS_SECRET           =  "changeme"

# Message of the day that D2CS greets players with
D2CS_MOTD             =  "Welcome to NaniBot's Diablo II server"

# Realm name that will be input to the D2CS configuration file
D2CS_REALM_NAME       =  "NaniBot's Realm"

# Server details (to be forwarded to pvpgn tracking sites)
# NOTE: Set to "unknown" if you do not wish to provide these details
SV_LOCATION           =  ":IN Bangalore, India"
SV_DESCRIPTION        =  "NaniBot's Diablo II Server LOD"
SV_URL                =  "https://www.nanibot.net"
SV_CONTACT_NAME       =  "NaniBot"

# Docker image name
DOCKER_IMAGE_NAME     =  "nanibot-d2gs"

# Docker image tag
DOCKER_IMAGE_TAG      =  "latest"