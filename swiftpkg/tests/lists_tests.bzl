"""Tests for `lists` module."""

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load("//swiftpkg/internal:lists.bzl", "lists")

def _compact_test(ctx):
    env = unittest.begin(ctx)

    actual = lists.compact([])
    asserts.equals(env, [], actual)

    actual = lists.compact([None, None, None])
    asserts.equals(env, [], actual)

    actual = lists.compact(["zebra", None, "apple"])
    asserts.equals(env, ["zebra", "apple"], actual)

    return unittest.end(env)

compact_test = unittest.make(_compact_test)

def _contains_test(ctx):
    env = unittest.begin(ctx)

    actual = lists.contains([], "apple")
    asserts.false(env, actual)

    actual = lists.contains(["zebra"], "apple")
    asserts.false(env, actual)

    actual = lists.contains(["zebra", "apple"], "apple")
    asserts.true(env, actual)

    return unittest.end(env)

contains_test = unittest.make(_contains_test)

def lists_test_suite():
    return unittest.suite(
        "lists_tests",
        compact_test,
        contains_test,
    )