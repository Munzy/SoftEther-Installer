# SoftEther-Installer

   Quickly install [SoftEther](https://www.softether.org/) on a Linux based server, and in just a few minutes! We do most of the heavy lifting, so that you don't have to!

## Install:

```
wget --no-check-certificate -qO- "https://raw.githubusercontent.com/Munzy/SoftEther-Installer/master/install.sh" | bash
```

Alternative Download: (IPv6 Supporting)
```
wget --no-check-certificate -qO- "https://git.enjen.net/munzy/SoftEther-Installer/raw/master/install.sh" | bash
```

## Get Your Own VM!
  Vultr! You can get a vm for as low as $2.50/month server. It includes 500GB/month of bandwidth! 
  
  They have locations in: Miami, Atlanta, Chicago, Silican Valley, Dallas, Los Angeles, New York, Seattle, London, Frankfurt, Paris, Amsterdam, Tokyo, Singaport, and Sydney.
  
  [Get your Vultr VM now!](https://www.vultr.com/?ref=6802596)
  
  Another amazing option is Catalysthost. You can get an amazing server in Dallas, or Seattle! I have been with Catalysthost for at least 3 years now. Great support, great servers, and a small American business.
  
  [Get your Catalysthost VM here!](https://portal.catalysthost.com/aff.php?aff=28)
  
  
  

## Currently tested on:

 - Ubuntu 16.04(x64)
 - Debian 8(x64)
 - Centos 7(x64)


## Currently does not work on:

  - Debian 9 -- Softether fails on make: https://github.com/SoftEtherVPN/SoftEtherVPN/issues/301
  - Ubuntu 17.04 -- Same as Debian 9.
  
## Bugs
  
  Debian has a small bug where systemd doesn't like to initially use server vpnserver stop. To get around this I just used /etc/init.d/vpnserver stop once and from then on it worked. Any ideas?
  
  
## Original Script

  The original script was made by [Ahmad Shamli](https://github.com/AhmadShamli) and is located on [Github](https://github.com/AhmadShamli/SoftEther-Installer).
  
  He originally got the idea, and setup from [Digital Oceans Library](https://www.digitalocean.com/community/tutorials/how-to-setup-a-multi-protocol-vpn-server-using-softether). 
  
  I decided to redo it because of issues, and problems with installing it on my KVM vms. I also decided I could make it a little easier of a process with a few tricks.
  
## Donations

If you like my projects, and work then please donate! 

https://www.cameronmunroe.com/coffee
