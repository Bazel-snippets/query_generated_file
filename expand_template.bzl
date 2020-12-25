# buildifier: disable=module-docstring
def _impl(ctx):
    template_path = ctx.file.template.owner.name
    # print("template_path = %s" % template_path) # header.h.tpl
    suffix = ".tpl"
    if not template_path.endswith(suffix):
        fail("template_path must end with %s" % suffix)
    index = template_path.rfind(suffix)
    header_path = template_path[:index]
    # print("header_path = %s" % header_path) # header.h

    header_file = ctx.actions.declare_file(header_path) 
    ctx.actions.expand_template(
        template = ctx.file.template,
        output = header_file,
        substitutions = {
            "#define TSTRING_UTF16": "#define TSTRING_UTF8",
        }
    )

    return DefaultInfo(files = depset([header_file]))

expand_template = rule(
    implementation = _impl,
    attrs = {
        "template": attr.label(allow_single_file = True),
    },
)