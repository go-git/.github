.PHONY: validate renovate-config-validate

validate:
	docker run --rm \
		-v "$$(pwd):/work" \
		-w /work \
		ghcr.io/renovatebot/renovate:41 \
		renovate-config-validator default.json .renovaterc.json5

renovate-config-validate: validate
