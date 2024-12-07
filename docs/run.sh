#!/bin/bash
ps aux | grep 'sphinx-autobuild' | awk '{print $2}' | xargs kill -9

sphinx-autobuild --host 0.0.0.0 source build/html &
