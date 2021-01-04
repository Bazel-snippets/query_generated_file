# buildifier: disable=module-docstring
def _impl(ctx):
    template_path = ctx.file.template.owner.name

    # print("template_path = %s" % template_path) # header.h.tpl
    suffix = ".tpl"
    if not template_path.endswith(suffix):
        fail("template_path must end with %s" % suffix)

    ctx.actions.expand_template(
        template = ctx.file.template,
        output = ctx.outputs.header_file,
        substitutions = {
            "#define TSTRING_UTF16": "#define TSTRING_UTF8",
        },
    )

    index = template_path.rfind(suffix)
    extra_header_path = template_path[:index] + ".2"

    # print("extra_header_path = %s" % header_path) # header.h.2
    extra_header_file = ctx.actions.declare_file(extra_header_path)
    ctx.actions.expand_template(
        template = ctx.file.template,
        output = extra_header_file,
        substitutions = {
            "#define TSTRING_UTF16": "#define TSTRING_UTF8",
        },
    )
    return DefaultInfo(files = depset(
        [
            ctx.outputs.header_file,
            extra_header_file,
        ],
    ))

expand_template = rule(
    implementation = _impl,
    attrs = {
        "template": attr.label(allow_single_file = True),
        "header_file": attr.output(),
    },
)
