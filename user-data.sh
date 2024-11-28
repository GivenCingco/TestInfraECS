                    #!/bin/bash
                    sudo dnf update
                    sudo dnf install -y postgresql16.x86_64 postgresql16-server
                    sudo postgresql-setup --initdb
                    sudo systemctl start postgresql
                    sudo systemctl enable postgresql
                    sudo systemctl status postgresql