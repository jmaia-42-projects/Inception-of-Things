# Vagrant tips
To destroy without the folder
```bash
vagrant global-status
# The answer gives an id per machine
vagrant destroy ia2b3c4d
```

# vagrant-libvirt *not working...*
[doc](https://vagrant-libvirt.github.io/vagrant-libvirt/installation)

> `memory` - Amount of memory in MBytes. Defaults to 512 if not set.

> `cpus` - Number of virtual cpus. Defaults to 1 if not set.

Seems like there is no need to change the settings...

Install deps => [installation script](https://raw.githubusercontent.com/vagrant-libvirt/vagrant-libvirt-qa/refs/heads/main/scripts/install.bash)

install plugins
```bash
vagrant plugin install vagrant-libvirt
```

add $USER to libvirt group => [solve an issue](https://forums.gentoo.org/viewtopic-t-1136670-start-0.html)
```bash
sudo usermod -aG libvirt $USER
```

## Issues
- [ ] [libvirt_ip_command](https://github.com/vagrant-libvirt/vagrant-libvirt/issues/1842)
  Seems like it doesnt really matter??
- [x] [nfs](sudo apt-get install nfs-common nfs-kernel-server)


# virtualbox
Worked with VirtulBox but... damn it is slowwwwww

## For p2
- [ingress](https://kubernetes.io/fr/docs/concepts/services-networking/ingress)
  *and that, but same infos* -> [ingress traefik](https://doc.traefik.io/traefik/providers/kubernetes-ingress)
- [hello-kub](https://github.com/paulbouwer/hello-kubernetes/blob/6e9ac0e273bfdaf1f9b78501e8b046be00d44eb3/docs/deploy-with-ingress.md#deploy-ingress-definition)
