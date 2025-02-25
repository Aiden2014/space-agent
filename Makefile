# Copyright (c) 2022 Institute of Software, Chinese Academy of Sciences (ISCAS)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

NAME=aospace
EXE=$(NAME)$(shell go env GOEXE)
DATE=$(shell date '+%F-%T')
BRANCH=$(shell git symbolic-ref HEAD | cut -d"/" -f 3)
COMMIT=$(shell git rev-parse HEAD | cut -c1-7)
VERSIONNUMBER="1.0.2"
VERSION=$(NAME)--"Agent-"$(VERSIONNUMBER)--$(DATE)-$(BRANCH)-$(COMMIT)
LDFLAGS=-ldflags "-s -w -X 'main.Version=${VERSION}' -X 'main.VersionNumber=${VERSIONNUMBER}'"
SOURCES=$(shell ls **/*.go)


.PHONY: all
all: exe

.PHONY: exe
exe: $(SOURCES) Makefile
	echo "building..."
	go env -w GO111MODULE=on
	go env -w GOPROXY="https://goproxy.io,direct"
	go build $(OPTIONS) $(LDFLAGS) -o build/$(NAME)

.PHONY: clean
clean:
	go clean -i
	rm -rf build/*
