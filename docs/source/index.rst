概要及目录
----------

    节能系统单元设备名称及功能概述:
    
    人体传感器：
        也称人体感应传感器，用于检测环境中是否有人出现，准确来说是检测环境内是否有物体 **移动** 。
        
        人体模块有红色、绿色两个LED灯，亮灭状态如表:
        
        +----------+--------+-------+
        |  **状态**|  绿灯  | 红灯  |
        +==========+========+=======+
        |    有人时|  常灭  | 常量  |
        +----------+--------+-------+
        |    无人时|  常灭  | 常闭  |
        +----------+--------+-------+
        |有人变无人| 亮一次 | 亮变灭|
        +----------+--------+-------+

    温度传感器：
        检测所处位置的环境温度。
        
        * 温度采集周期: 3秒
        * 采集精度: 0.1

.. toctree::
    :maxdepth: 2
    :caption: 目录
    :name: mastertoc

    docs/controller/features
    docs/controller/upgrade    
    docs/human/index
    docs/temperature/index
    docs/collector/index    
    docs/testcase/index
    docs/controller/glossary
