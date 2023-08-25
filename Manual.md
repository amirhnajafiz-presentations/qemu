# Manual

In manual part we are going to see two base example of using ```QEMU``` in order to virtualize
our system.

## VM Creation

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

## CPU Hotplugin

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

## Adding a new vCPU

From its output, we can see that **IvyBridge-IBRS-x86_64-cpu** is present in socket 1,
while hot-plugging a CPU into socket 1 requires passing the listed properties to QMP device_add:

```shell
device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=0 core-id=1 thread-id=0
```

### Question 1

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

### Removing vCPU

From the ```qmp-shell```, invoke the QMP ```device_del``` command:

```shell
device_del id=cpu-2
```
