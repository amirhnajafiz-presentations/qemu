<p align="center">
  <img src="assets/readme/logo.jpg" alt="logo" width="500" />
</p>

<p align="center">
  <b>Cloud Computing</b> presentation at <i>Amirkabir University of Tehran, Iran</i><br />
  Cloud Computing Course Fall 2022-23<br />
  <b>Dr. Seyed Ahmad Javadi</b>
</p>

<br />

___

<br />

## What is QEMU?

**QEMU** is a generic and open source machine & userspace _Emulator_ and _Virtualizer_.
It is capable of _emulating_ a complete machine in software without any
need for hardware virtualization support.

By using dynamic translation, it achieves very good performance. It can also integrate with
the Xen and KVM hypervisors to provide emulated hardware while allowing the hypervisor to manage the CPU.
With hypervisor support, **QEMU** can achieve near native performance for CPUs.

<br />

## Why QEMU?

**QEMU** emulates the machine's processor through dynamic binary translation and provides a set of
different hardware and device models for the machine, enabling it to run a variety of guest operating systems.
It aims to fit into a variety of use cases. It can be invoked directly by users wishing to have full control over its behaviour and settings.
It also aims to facilitate integration into higher level management layers, by providing a stable command line interface and monitor API.

<br />

## QEMU architecture

Analysis of QEMU and KVM.

<p align="center">
  <img src="assets/qemu/kvm-model.png" alt="qemu-arch" width="700" />
</p>

### Notes

- KVM: Kernel-based Virtual Machine (KVM) is an open source virtualization technology built into Linux.
- VMCS: Virtual Machine Control Structure.

VM enter:

<p align="center">
  <img src="assets/qemu/vm-enter.png" alt="kvm-in" width="700" />
</p>

VM exit:

<p align="center">
  <img src="assets/qemu/vm-exit.png" alt="kvm-out" width="700" />
</p>

### qemu levels

### qemu main modules

### qemu CPU module

<br />

## Executing QEMU on your local PC

Clone into the presentation repository to access **QEMU** source codes:

```shell
git clone https://github.com/amirhnajafiz/QEMU
```

Go inside ```src``` directory and build **QEMU** by running the following commands:

```shell
cd src
../configure
make
```

<br />

## QEMU vs VirtualBox

As discussed earlier, **QEMU** can be used for emulation and virtualization, however, **VirtualBox** can be used for virtualization only. QEMU comes with dual support of emulation and virtualization whereas the latter provides only virtualization features.

**QEMU/KVM** is better integrated in Linux, has a smaller footprint and should therefore be faster. **VirtualBox** is a virtualization software limited to x86 and amd64 architecture. Xen uses **QEMU** for the hardware assisted virtualization, but can also paravirtualize guests without hardware virtualisation

<br />

## Additional Information

Additional information can also be found online via the QEMU website:

- [QEMU on Linux](https://www.qemu.org/download/#linux)
- [QEMU on Windows](https://www.qemu.org/download/#windows)
- [QEMU on MacOS](https://www.qemu.org/download/#macos)

<br />

## Presentation Resources

- [QEMU website](https://www.qemu.org/)
- [QEMU documents](https://www.qemu.org/docs/master/)
- [QEMU Architecture](https://wiki.qemu.org/Documentation/Architecture)
- [GiantVM](https://github.com/GiantVM/QEMU)
- [How to build QEMU?](https://www.howtogeek.com/devops/how-to-use-qemu-to-boot-another-os/)
- [Virtualbox vs QEMU](https://linuxhint.com/qemu-vs-virtualbox/#:~:text=Key%20Differences%20between%20QEMU%20and,latter%20provides%20only%20virtualization%20features.)
