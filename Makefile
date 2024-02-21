FLUX_BOOTSTRAP_PATH := bootstrap/clusters/sandman01

.PHONY: bootstrap-flux

bootstrap-flux:
	@echo "Bootstrapping FluxCD..."
	@./bigbang/higgsboson.sh $(FLUX_BOOTSTRAP_PATH)
