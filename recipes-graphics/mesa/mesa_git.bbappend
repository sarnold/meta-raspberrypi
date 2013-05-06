# FIXME: We may need to disable EGL, GL ES1 and GL ES2
python __anonymous () {
    import re

    # Remove egl gles1 and gles2 configure options
    extra_oeconf = d.getVar('EXTRA_OECONF', True).split()
    take_out = ['--enable-egl', '--enable-gles2']
    put_in = ['--disable-egl', '--disable-gles2']
    pattern = re.compile("--with-egl-platforms")
    new_extra_oeconf = []
    for i in extra_oeconf:
        if i not in take_out and not pattern.match(i):
            new_extra_oeconf.append(i)
    for i in put_in:
        new_extra_oeconf.append(i)

    d.setVar('EXTRA_OECONF', ' '.join(new_extra_oeconf))

    # Remove itens from provides
    provides = d.getVar('PROVIDES', True).split()
    take_out = ['virtual/libgles2', 'virtual/egl']
    new_provides = []
    for i in provides:
        if i not in take_out:
            new_provides.append(i)

    d.setVar('PROVIDES', ' '.join(new_provides))

    # We are now machine specific
    d.setVar('PACKAGE_ARCH', d.getVar('MACHINE_ARCH'))
}