节能控制
++++++++++++

概述
-------

    传送至\ 实验_\ 

    节能控制是指通过对负载电器设备的用电情况施加外部控制,以实现节能电力能源的目标. 当前系统中, 节能控制主指 *控制器* 对空调机的运行数据采集和运算。
    当预设条件发生后,控制器将采取一系列的可用控制指令/行为对空调机的运行情况施加干预,以实现空调机的制冷 停止 开机 关机操作。

    节能相关操作页面
        .. image:: /_static/imags/platform_ops/ps-on_offj.png
            :width: 80%
    
    在目标控制器的 \ **运行状态**\  页中, 每台空调配有 \|\ *空调通电状态*\  \| \ *压缩机运行状态*\  \| \ *节能状态*\ \|功能选项。
    除此之外, 还有一系列\ :ref:`节能配置`\ 作为控制器运行节能的参考指标使用, 在控制器运行过程中,通过网络分发至每个控制器。

节能操作及约束
----------------

节能操作
==========

          *如图所示，* **\ 压缩机运行状态： 运行  待机**\ , 将在后续版本中修改为  **开关机:   开机   关机**\ ,文档中使用 开关机:开机 关机 组合。

        - **空调通电状态:** 如上图所示, 此项包含 "通电"、"断电" 两个选项, 
          通电 表示下发断电指令, 下发后该指令将通过控制器转发至采集器完成空调机进电开启。
          断电 将会触发采集器执行断电操作, 成功后空调机进电关闭。
        - **开关机:** 包含"开机"、"关机" 两个选项, 当运行指令下发后, 空调机执行"空调开机", 当"关机"指令下发后, 空调机执行"空调关机" "空调待机" *(与空调机定义相关)*\ 。
        - **节能状态:** 有"开启"、"关闭"两个选项, 选中开启后, 控制器将参考\ :ref:`节能配置`\ 对空调机的工作状态实施控制. 选中"关闭"后, 
          控制器将放弃对空调机的自动控制 *(平台手动下发命令有效)*。

操作约束
==============

        控制器版本： *<=SECO_KSW_001_CO_01_31_250113*

        操作约束是指，\ **节能**\ 自动运行期间因自动运行的逻辑限制，可能导致部分\ *手动命令*\ 不能生效的情况。手动命令可否执行的参考下表:

        * 节能状态"关闭"时 \ *可参考用例*\ \ :ref:`2100 [指令控制分合闸] 节能关闭`\ 

                +--------------------+--------------------+
                |    空调通电状态    |    最小执行周期    |
                +====================+====================+
                +        通电        +         30s        +
                +--------------------+--------------------+
                +        断电        +         30s        +
                +--------------------+--------------------+

                +--------------------+--------------------+
                |   压缩机运行状态   |    最小执行周期    |
                +====================+====================+
                +      运行          +         30s        +
                +--------------------+--------------------+
                +      待机          +         30s        +
                +--------------------+--------------------+


        * 节能状态"开启"时

                节能开启后， 下发“空调通电状态”、“压缩机运行状态” 的状态，受到控制器“节能控制”的运算影响，手动下发的指令\ **不受保障**\ 。
                
                \ *如： 当空调机处于运行状态时， 平台下发“断电”指令， 控制器收到指令后将等待空调机待机/关机后才会执行“断电”， 
                如空调机总是处于“制冷”工作时，将导致“断电”命令永不被执行*\ 

        * 当控制器通电且节能开启时

                -  不能操作 **开关机** 的原因在于：节能逻辑接管空调期间，以环境温度是否达到关机水平为最优先，当环境温度居高不下时， **关机** 命令会被搁置，得不到执行。
                -  不能操作 **断电** 的原因在于：当空调机运行且压缩机运转期间，断电的操作有可能损坏空调的核心-压缩机，故在 **断电** 不可被执行。


实验
========

        以下内容为，对平台中“运行控制”下按钮可操作与不可操作要求的描述。

        方案一 （ *乱七八糟 且 未能穷尽所有情况。废弃吧， 最好忽略 不要看了* ）

                * 空调通电状态
                        
                        - 断开： 不可操作\ **开关机**\ , 不可操作\ **节能状态**\ 
                        - 通电： 
                                - 节能状态-关闭:  可以操作\ **开关机**\ , 可以操作\ **节能状态**\ 
                                - 节能状态-开启： 不可操作\ **空调通断电状态**\ ，不以操作\ **节能状态**\ 

                * 节能状态

                        - 关闭： 可以操作\ **空调通断电状态**\ ，可以操作\ **节能状态**\ 
                        - 开启： 不可操作\ **空调通断电状态**\ ，不以操作\ **节能状态**\ 

        方案二

                #. ( 空调通电状态： 断开 ) ----> **禁止操作** 开关机、节能状态 。
                #. ( 空调通电状态： 通电 + 节能状态： 开启 ) ----> **禁止操作** 分合闸、开关机 。
