include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PercentageBatteryX
PercentageBatteryX_FILES = Tweak.xm
PercentageBatteryX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
after-uninstall::
	uninstall.exec "killall -9 SpringBoard"
