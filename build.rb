#! /usr/bin/env ruby

all = [
  'Python',
  'Ruby',
  'JavaScript',
  'PHP',
  'C',
  'Go',
  'Java',
  'CSharp',
  'C-Media',
  'OSSFS'
]

puts <<EEE
# OSS SDK Status

Language | Version | Build | Coverage | Stars | Issues
---      | ---     | ---   | ---      | ---   | ---
EEE

def name_for(s, n)
  "#{s}-#{n}".downcase
end

COLS = ['repo', 'version', 'build', 'coverage', 'star', 'issue']

all.each do |s|
  cols = COLS.map { |x|
    if x == 'repo'
      text = (s == 'CSharp' ? 'C#' : s)
      link = name_for(s, x)
      "[#{text}][#{link}]"
    else
      link = name_for(s, x)
      alt = link.capitalize
      "![#{alt}][#{link}]"
    end
  }

  puts cols.join(' | ')
end

puts

def repo_name(s)
  lang = s.downcase
  if lang == 'media-c'
    'aliyun/aliyun-media-c-sdk'
  elsif lang == 'javascript'
    'ali-oss/ali-oss'
  elsif lang == 'csharp'
    'aliyun/aliyun-oss-csharp-sdk'
  elsif lang == 'ossfs'
  else
    "aliyun/aliyun-oss-#{lang}-sdk"
  end
end

def repo_for(s)
  "https://github.com/#{repo_name(s)}"
end

def version_for(s)
  {
    'python' => 'https://badge.fury.io/py/oss2.svg',
    'ruby' => 'https://badge.fury.io/rb/aliyun-sdk.svg',
    'php' => 'https://poser.pugx.org/aliyuncs/oss-sdk-php/v/stable',
    'java' => 'https://badge.fury.io/gh/aliyun%2Faliyun-oss-java-sdk.svg',
    'csharp' => 'https://badge.fury.io/gh/aliyun%2Faliyun-oss-csharp-sdk.svg',
    'javascript' => 'https://badge.fury.io/js/ali-oss.svg',
    'go' => 'https://badge.fury.io/gh/aliyun%2Faliyun-oss-go-sdk.svg',
    'c' => 'https://badge.fury.io/gh/aliyun%2Faliyun-oss-c-sdk.svg',
    'c-media' => 'https://badge.fury.io/gh/aliyun%2Faliyun-media-c-sdk.svg',
    'ossfs' => 'https://badge.fury.io/gh/aliyun%2Fossfs.svg'
  }[s.downcase]
end

def build_for(s)
  "https://travis-ci.org/#{repo_name(s)}.svg?branch=master"
end

def coverage_for(s)
  lang = s.downcase
  if lang == 'javascript'
    "http://codecov.io/github/#{repo_name(s)}/coverage.svg?branch=master"
  else
    "https://coveralls.io/repos/#{repo_name(s)}/badge.svg?branch=master"
  end
end

def star_for(s)
  "https://img.shields.io/github/stars/#{repo_name(s)}.svg?style=social&label=Star&maxAge=3600"
end

def issue_for(s)
  "https://img.shields.io/github/issues/#{repo_name(s)}.svg?maxAge=3600"
end

all.each do |s|
  COLS.each do |c|
    value = self.send("#{c}_for", s)
    puts "[#{name_for(s, c)}]: #{value}"
  end
  puts
end

puts <<EEE
# Development (OSS members only)

We prefer the *branch way* to the *fork way*, in order to run function
tests in travis CI. **DO NOT** push directly to master branch unless
you're making trivial changes such as fixing typo.

## Clone

```bash
git clone git@github.com:aliyun/aliyun-oss-ruby-sdk.git
```

## Branch

Pick a branch name for your change and then:

```bash
cd aliyun-oss-ruby-sdk
git branch refine-readme
git checkout refine-readme
# edit files
git add xxx
git commit -m "bla bla bla"

git push origin refine-readme
```

## Pull request

Create a pull request from branch `refine-readme` to `master`:

![Create PR](create_pr.png?raw=true "Create pull request")

Follow the CLAAssistant and Sign CLA:

![Sign CLA](sign_cla.png?raw=true "Sign CLA")

Check the tests PASS and coverage DOES NOT DROP. Then Merge the pull
request and delete the branch:

![Accept PR](accept_pr.png?raw=true "Accept PR")
![Delete Branch](delete_branch.png?raw=true "Delete Branch")
EEE
