.PHONY: bootstrap-flux

GITHUB_USERNAME := rdemoraes
REPOSITORY_URL := git@github.com:$(GITHUB_USERNAME)/k8s-fluxcd-bootstrap.git
GITHUB_TOKEN := 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
NAMESPACE := fluxcd

bootstrap-flux:
    @echo "Bootstrapping FluxCD..."
    @./shell-script/bootstrap_flux.sh $(GITHUB_USERNAME) $(REPOSITORY_URL) $(GITHUB_TOKEN) $(NAMESPACE)
