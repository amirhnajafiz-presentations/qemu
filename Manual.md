# Manual

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

You tell me!

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
