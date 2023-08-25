# Manual

In manual part we are going to see two base example of using ```QEMU``` in order to virtualize
our system.

## 1. VM Creation

In first example we are going to create a virtual machine on our system using ```QEMU```.

### create directory

Before creating a directory to make drives, download an operating system iso image. You can use
Ubuntu, Alpine, Bullseye, etc.

```shell
mkdir Ubuntu-VM
sudo mv /path/to/ubuntu.iso ./Ubuntu-VM
```

### create image file

Now create an image file in order to boot qemu from it.

```shell
cd Ubuntu-VM
qemu-img create -f qcow2 Image.img 20G
```

The above command will create a virtual disk image file that's 20GB in size. The virtual machine will use this disk image to store data, so make sure to specify a size accordingly.

### start vm

Next, run the following command to start the Ubuntu virtual machine:

```shell
qemu-system-x86_64 -enable-kvm -cdrom ubuntu.iso -boot menu=on -drive file=Image.img -m 4G -cpu host -vga virtio -display sdl,gl=on
```

The virtual machine window will pop up. Press Escape to open the boot menu and select the appropriate option to boot from the ISO file.

### restart vm

After installing Ubuntu, make sure you remove the -cdrom flag from the qemu command. This will boot Ubuntu from the disk image file rather than the ISO file.

```shell
qemu-system-x86_64 -enable-kvm -boot menu=on -drive file=Image.img -m 4G -cpu host -vga virtio -display sdl,gl=on
```

## 2. Hosting QEMU VMs with Public IP Addresses using TAP Interfaces

To allow VMs to have their own IP addresses while using the same physical link, we need to introduce a bridge into this setup.
Both the VM’s network interface as well as the host’s interface will be connected to the bridge.

### create bridge

```shell
ip link add br0 type bridge
ip link set br0 up
```

Next, we want to connect the eth0 interface to the bridge and re-assign the IP address from eth0 to br0. Please note that these commands
will drop internet connectivity of your machine, so either only run them on a local PC or ensure that in case of disaster
you can reboot the machine somehow.
```192.168.0.10``` is just an example IP address, you need to use your own of course.

### add ip to bridge

```shell
ip link set eth0 up
ip link set eth0 master br0

ip addr flush dev eth0

ip addr add 192.168.0.10/24 brd + dev br0
ip route add default via 192.168.0.1 dev br0
```

### tap interface

Next, we can create the TAP interface to be used by the VMs. ```$YOUR_USER``` is used to allow an unprivileged user to connect to the TAP device.
This is important for QEMU, since QEMU VMs should be started as non-root users.

```shell
ip tuntap add dev tap0 mode tap user $YOUR_USER
ip link set dev tap0 up
ip link set tap0 master br0
```

### start

And now we can start a VM. The MAC address could e.g. be generated randomly:

```shell
RAND_MAC=$(printf 'DE:AD:BE:EF:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)))

qemu-system-x86_64 -m 1024 -cdrom archlinux-2020.05.01-x86_64.iso \
   -device virtio-net-pci,netdev=network0,mac=$RAND_MAC \
   -netdev tap,id=network0,ifname=tap0,script=no,downscript=no
```

## 3. CPU Hotplugin

Run ```qmp-shell``` (located in the source tree, under ‍‍‍‍```/scripts/qmp/```) to connect to the just-launched **QEMU**:

```shell‍‍‍‍‍‍‍‍‍‍‍‍‍‍‍‍
./qmp-shell -p -v /tmp/qmp-sock
```

Find out which CPU types could be plugged, and into which sockets:

```shell
query-hotpluggable-cpus
```

The ```query-hotpluggable-cpus``` command returns an object for CPUs that are present
(containing a ```qom-path``` member).

### adding a new vCPU

From its output, we can see that **IvyBridge-IBRS-x86_64-cpu** is present in socket 1,
while hot-plugging a CPU into socket 1 requires passing the listed properties to QMP device_add:

```shell
device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=0 core-id=1 thread-id=0
```

#### Question 1

<details>

<summary> What is driver in this command? </summary>

<br />

<pre>
Cpu model type name.
In here it is IvyBridge-IBRS-x86_64-cpu.
</pre>

</details>

<br />

Optionally, run QMP ```query-cpus-fast``` for some details about the vCPUs:

```shell
query-cpus-fast
```

### removing vCPU

From the ```qmp-shell```, invoke the QMP ```device_del``` command:

```shell
device_del id=cpu-2
```

## Resources

- [blog.stefan-koch.name](https://blog.stefan-koch.name/2020/10/25/qemu-public-ip-vm-with-tap)
