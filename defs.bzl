# buildifier: disable=module-docstring
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//vendor:defs.bzl", _crate_repositories = "crate_repositories")

def grpc_health_check_repositories():
    """Repositories used in the implementation of `grpc_health_check`."""

    maybe(
        http_archive,
        name = "rules_proto",
        urls = [
            "https://github.com/bazelbuild/rules_proto/archive/refs/tags/5.3.0-21.7.tar.gz",
        ],
        sha256 = "dc3fb206a2cb3441b485eb1e423165b231235a1ea9b031b4433cf7bc1fa460dd",
        strip_prefix = "rules_proto-5.3.0-21.7",
    )

    maybe(
        http_archive,
        name = "rules_rust",
        urls = [
            "https://github.com/bazelbuild/rules_rust/releases/download/0.18.0/rules_rust-v0.18.0.tar.gz",
        ],
        sha256 = "2466e5b2514772e84f9009010797b9cd4b51c1e6445bbd5b5e24848d90e6fb2e",
    )

grpc_health_check_crate_repositories = _crate_repositories
