.PHONY: cybercommon-init cybercommon-build cybercommon-run cybercommon-stop

cybercommon-init:
	$(MAKE) -C CyberCommons init

cybercommon-build:
	$(MAKE) -C CyberCommons build

cybercommon-run:
	$(MAKE) -C CyberCommons run

cybercommon-stop:
	$(MAKE) -C CyberCommons stop