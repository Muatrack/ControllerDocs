
通信协议
=========

    **MODBUS**
        系统中使用的modbus协议，其中的字节顺序使用 Little endian byte swap， 即 *小端字节交换* 规则
        .. code::
            /** 待传输的数据字节顺序 ABCD **/
            1. 传输前将 ABCD 转换为 DCBA 
            2. 将 DCBA 组帧，总线发送数据帧.