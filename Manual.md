# Manual

Run ```qmp-shell``` (located in the source tree, under: /scripts/qmp/) to connect to the just-launched QEMU:

```shell
./qmp-shell -p -v /tmp/qmp-sock
```

Find out which CPU types could be plugged, and into which sockets:

```shell
query-hotpluggable-cpus
```

The query-hotpluggable-cpus command returns an object for CPUs that are present
(containing a ```qom-path``` member) or which may be hot-plugged (no ```qom-path``` member).

From its output in step (3), we can see that IvyBridge-IBRS-x86_64-cpu is present in socket 0,
while hot-plugging a CPU into socket 1 requires passing the listed properties to QMP device_add:

```shell
device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
```

Optionally, run QMP query-cpus-fast for some details about the vCPUs:

```shell
query-cpus-fast
```

From the ```qmp-shell```, invoke the QMP device_del command:

```shell
device_del id=cpu-2
```
