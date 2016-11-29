FROM devinci/drupal-cli

RUN #deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu precise main:wq

# Remove a PPA that isn't even active anymore (404) so that we can install rvm
RUN \
    sed -i "s^deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu precise main^#deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu precise main^g" /etc/apt/sources.list && \
    cat /etc/apt/sources.list

# Add dependencies for installing compass with rvm
RUN \
    apt-get update && \
    apt-get -y --force-yes install \
        # Includes things like gcc, make, etc
        build-essential \
        # Required because ffi ruby gem is required by compass.
        libffi-dev

RUN \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby && \
    # Enable rvm environment.
    # Enable rvm environment for future logins as well.
    echo 'source /etc/profile.d/rvm.sh' >> ~/.bashrc && \
    #rvm install 2.0.0
    #rvm use 2.0.0
    #rvm rubygems latest
    bash --login -c 'ruby --version && gem install bundler' \

