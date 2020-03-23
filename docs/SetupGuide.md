# Setup guide

This is simple setup guide to help you get started. It uses the simplest configuration which works nearly out of the box.

## Steps

1. Init configuration directory with initial config files:

  ``` bash
  # Starts temporary container, soo you will be able to generate intial config files and opens bash shell in container
  docker run -it --rm --cap-add NET_ADMIN -e SKIP_APP=true -v </path/to/config>:/config slocomptech/openvpn:latest bash
  ```
2. Edit `vars` file
3. At this point you will have bash shell which runs in container. Now run following commands to **setup your PKI**:  

  ``` bash
  ovpn pki init [nopass] # Inits PKI
  #CA settings are located in /config/ssl/vars
  #Did you modified the file or are you planing to enter values interactively ?
  #[y/N]: y
  #
  #init-pki complete; you may now create a CA or requests.
  #Generating DH parameters, 2048 bit long safe prime, generator 2
  #This is going to take a long time
  #.................................
  #DH parameters of size 2048 created at /config/pki/dh.pem
  #
  #Now it will build CA files for issuing new certifiactes
  #Please protect ca.key with secure password (used for signing new certs)
  #ca.key is needed only for signing new certificates, not for OpenVPN to work

  #Using SSL: openssl OpenSSL 1.1.1a  20 Nov 2018
  #Enter New CA Key Passphrase: <ENTER SECRET PKI PASSWORD>
  #Re-Enter New CA Key Passphrase: <ENTER SECRET PKI PASSWORD>
  #Generating RSA private key, 2048 bit long modulus (2 primes)
  #...............................+++++
  #You are about to be asked to enter information that will be incorporated
  #into your certificate request.
  #What you are about to enter is what is called a Distinguished Name or a DN.
  #There are quite a few fields but you can leave some blank
  #For some fields there will be a default value,
  #If you enter '.', the field will be left blank.
  #-----
  #Common Name (eg: your user, host, or server name) [Easy-RSA CA]: <COMMON NAME OF YOUR CA>
  #
  #CA creation complete and you may now import and sign cert requests.
  #
  #Generating a RSA private key
  #..............+++++
  #writing new private key to '/config/pki/private/server.key.osYA8Mim31'
  #-----
  #Enter pass phrase for /config/pki/private/ca.key: <ENTER SECRET PKI PASSWORD>
  #Check that the request matches the signature
  #Signature ok
  #The Subject's Distinguished Name is as follows
  #commonName            :ASN.1 12:'server'
  #Certificate is to be certified until Mar  4 21:36:34 2022 GMT (1080 days)
  #
  #Write out database with 1 new entries
  #Data Base Updated
  #
  #You are about to sign the following certificate.
  #Please check over the details shown below for accuracy. Note that this request
  #has not been cryptographically verified. Please be sure it came from a trusted
  #source or that you have verified the request checksum with the sender.
  #
  #Request subject, to be signed as a server certificate for 1080 days:
  #
  #subject=
  #    commonName                = server
  #
  #Type the word 'yes' to continue, or any other input to abort.
  #  Confirm request details: <YES>
  #Enter pass phrase for /config/pki/private/ca.key: <ENTER SECRET PKI PASSWORD>
  #Check that the request matches the signature
  #Signature ok
  #The Subject's Distinguished Name is as follows
  #commonName            :ASN.1 12:'server'
  #The matching entry has the following details
  #Type          :Valid
  #Expires on    :220304213634Z
  #Serial Number :DA40AFDB4E9D5C1D596BA698A2EBC1BE
  #File name     :unknown
  #Subject Name  :/CN=server
  #
  #Enter pass phrase for /config/pki/private/ca.key: <ENTER SECRET PKI PASSWORD>
  #
  #An updated CRL has been created.
  #CRL file: /config/pki/crl.pem
  ```

  **Note:** You can generate PKI without password, just use `nopass` option.  

4. Setup OpenVPN config based on example `basic` with configuration wizard:

  ``` bash
  ovpn enconf basic
  #Out interface [eth0]: <interface connected to the Internet>
  #Protocol udp, tcp, udp6, tcp6 [udp]:
  #VPN network [10.0.0.0]:
  #Port [1194]:
  #Public IP or domain of server: <PUBLIC IP>
  #DNS1 [8.8.8.8]:
  #DNS2 [8.8.4.4]:
  ```

  **Note:** If you are using this container for production use your Public IP (if you don't know it, check with `whatsmyip` website and make sure it is **static**, for testing purposes at home, you can use local IP).
5. Generate server certificate

  ``` bash
  ovpn subject add server server [nopass] # First server is name
  ```

6. Enable **port forwarding** on your router so OpenVPN server will be accessible from the internet.
7. Add clients to your server

  ``` bash
  # Generates client certificates
  ovpn subject add <name> client [nopass]

  # Manually generates client config file and saves it to /config/client-configs
  ovpn subject gen-ovpn <name>
  ```

**Note:** Client config files MUST be transported to your devices via **SECURE** method such as USB (email is considered **INSECURE**).

8. Exit container with `exit`, then it will destroy itself.
9. Now you can create config file outside container, mentioned above.
10. If you need to access bash shell again (to add another client after server was started) just use `docker exec -it <container name> bash`.
11. Start container using normal command:

    ``` bash
    docker run \
    --name=ovpn \
    --cap-add NET_ADMIN \
    -e PUID=1000 \
    -e GUID=1000 \
    -p 1194:1194/udp \
    -v </path/o/config>:/config \
    --restart=unless-stopped \
    --network host \
    slocomptech/openvpn:latest
    ```

**Note:** PUID, GUID parameters are optional.  
**Note:** Container in this example will connect to host network, so there is less network overhead (recommended), this also works if container is in default docker network. (But be careful if you already have firewall configured, because some rules are added when using most of examples).  
