#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

FROM ruby:2.4.3

RUN apt-get update && apt-get clean

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
# Copy source files after the bundle install, this
# makes source update rebuilds much faster because
# the gem installation is already done.
COPY . .
RUN rake db:setup

EXPOSE 3000
#EXPOSE 1234
ENV RUBYLIB ""

CMD ["rails", "server", "-b", "0.0.0.0"]
#CMD ["rdebug-ide", "--host", "0.0.0.0", "--port", "1234", "--dispatcher-port", "26162", "--", "/usr/local/bundle/bin/rails", "server", "-b", "0.0.0.0", "-e", "development"]



