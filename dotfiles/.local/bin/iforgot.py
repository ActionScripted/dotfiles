#!/usr/bin/env python
"""
iforgot
--
Things I forget; terse and verbose.
"""

__author__ = 'Michael Thompson (actionscripted@gmail.com)'
__copyright__ = 'Copyright (c) Michael Thompson'
__license__ = 'BSD-3-Clause'
__version__ = '1.0'


from argparse import ArgumentParser

# String indent
INDENT = '    '

# Use a mix of sets and arrays mostly for readability
MEMORIES = (
    (['arp -a'], [
        'View current ARP entries (IP to MAC)',
    ]),
    (['curl -Lvso /dev/null somesite.com'], [
        'redirects (L), verbose (v), silent (s), output to /dev/null (o)',
    ]),
    (['curl -d "foo=bar" -H "Content-Type: application/json" -X POST http://somesite.com'], [
        'POST (X) data (d) with headers (h)',
    ]),
    (['curl ipinfo.io/ip'], [
        'view public IPV4 address',
    ]),
    (['dot_clean some_folder'], [
        'remove Apple Double files like ._somefile',
    ]),
    (['find . -type f -exec chmod 644 {} \\;',
      'find . -type d -exec chmod 755 {} \\;'], [
        'sane webserver file defaults',
    ]),
    (['find . -type f -name "*.txt" -exec grep -i "mike stinks" +'], [
        'find all text files and pass grep the full list at once',
    ]),
    (['git diff > coolstuff.patch; git apply coolstuff.patch'], [
        'create a patch; apply a patch',
    ]),
    (['git fetch upstream pull/1234/head && git checkout FETCH_HEAD'], [
        'checkout pull request by ID (1234)',
    ]),
    (['git tag -a v1.0 -m "some awesome info or message"'], [
        'create an annotated (-a) git tag with a message (-m)',
    ]),
    (['nc -v some-host.com 8080'], [
        'netcat verbose (-v) connection to some-host.com port 8080',
    ]),
    (['sudo nmap -sn 10.0.0.1/24'], [
        'Scan network CIDR (ping sweep); no port scan'
    ]),
    (['openssl s_client -showcerts -connect somesite.com:443 -servername somesite.com'], [
        'View certificate information for somesite.com w/SNI',
    ]),
    (['pushd /some/path; dirs -v; popd;'], [
        'Change to /some/path, add to stack; show stack; cd and remove top of stack',
    ]),
    (['rsync -av --exclude ".git" user@host:source/path ./destination/path'], [
        'Sync as archive (man page: "same as -rlptgoD") excluding .git dirs',
        '-r recursive',
        '-l preserve symlinks',
        '-p partial/progress',
        '-t preserve modification times',
        '-g preserve group',
        '-o preserve owner',
        '-D preserve device files',
    ]),
    (['sudo adduser michael turkeys'], [
        'add user "michael" to group "turkeys"',
    ]),
    (['tar -czvf your-file.tar.gz somedir'], [
        'Compress (c), gzip (z), verbose (v), [using this] file (f) the "somedir" dir',
    ]),
    (['[mkdir somedir && ] tar -xzvf your-file.tar.gz -C somedir'], [
        'Extract (x), unzip (z), verbose (v), [using this] file (f) to "somedir" dir',
    ]),
    (['(Vim CLI) :%!python -m json.tool'], [
        '(from within Vim) format JSON',
    ]),
    (['wget https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'], [
        'Download an OFFICIAL dummy PDF!',
    ]),
)

# Choices for level of recollection
VERBOSITY_LEVEL_0 = 0
VERBOSITY_LEVEL_1 = 1
VERBOSITY_LEVEL_2 = 2

# Default recollection: STFU
VERBOSITY_DEFAULT = VERBOSITY_LEVEL_0


# Group of Different functions for different styles
class Style():
    BLACK = '\033[30m'
    BLUE = '\033[34m'
    BOLD = '\033[1m'
    CYAN = '\033[36m'
    FAINT = '\033[2m'
    GREEN = '\033[32m'
    MAGENTA = '\033[35m'
    RED = '\033[31m'
    RESET = '\033[0m'
    UNDERLINE = '\033[4m'
    WHITE = '\033[37m'
    YELLOW = '\033[33m'


def remember(search=None, verbosity=VERBOSITY_DEFAULT):
    memory_count = 0

    for m in MEMORIES:
        if search and search.lower() not in ''.join(m[0]).lower():
            continue
        else:
            memory_count += 1

        for cmd in m[0]:
            print(Style.YELLOW + cmd)

        if verbosity >= VERBOSITY_LEVEL_1:
            print(Style.RESET + f'{INDENT * 1}{m[1][0]}')

        if verbosity >= VERBOSITY_LEVEL_2:
            for mm in m[1]:
                # Deja vu?!
                if m[1][0] == mm:
                    continue

                print(Style.FAINT + f'{INDENT * 2}{mm}')

            # No newline (or default) if not verbose. We still want the reset
            # but we don't want to space out unless verbose.
            print_kwargs = {'end': ''} if verbosity >= VERBOSITY_LEVEL_1 else {}
            print(Style.RESET, **print_kwargs)

    if not memory_count:
        print('(no matches)')


if __name__ == '__main__':
    parser = ArgumentParser(description='Remember!')

    parser.add_argument('search',
                        help='Search query (optional)',
                        metavar='SEARCH',
                        nargs='?')
    parser.add_argument('-v',
                        action='store_true',
                        dest='verbose_1',
                        help='verbosity level 1')
    parser.add_argument('-vv', '--verbose',
                        action='store_true',
                        dest='verbose_2',
                        help='verbosity level 2')

    args = parser.parse_args()

    if args.verbose_1:
        verbosity = 1
    elif args.verbose_2:
        verbosity = 2
    else:
        verbosity = VERBOSITY_DEFAULT

    remember(args.search, verbosity)
