import os
import time
import logging

import tableauserverclient as TSC
import tableaudocumentapi as TDI

logging.basicConfig(level=logging.DEBUG)

username = os.getenv("TABLEAU_USERNAME")
password = os.getenv("TABLEAU_PASSWORD")
tab_server = os.getenv("TABLEAU_SERVER") + "/"
site_name = "wisemuffindev254014"

print(TSC.__version__)

# initlaise server
tableau_auth = TSC.TableauAuth(username, password, site_name)
server = TSC.Server(tab_server)

tds = "Orders Prod Clone.tds"
# tds = "Orders Prod.tds"
project_id = "b599e7e1-d59d-4690-9912-d9b23941d25c"

with server.auth.sign_in(tableau_auth):

    # d = server.projects.get()
    datasource_item = TSC.DatasourceItem(name=tds, project_id=project_id)
    server.datasources.publish(
        datasource_item,
        f"./tableau/tab_downloads/datasources/{tds}",
        "Overwrite",
        connection_credentials=None,
    )

