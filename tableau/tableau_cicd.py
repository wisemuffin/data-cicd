import os
import time
import logging

import tableauserverclient as TSC

logging.basicConfig(level=logging.DEBUG)

username = os.getenv("TABLEAU_USERNAME")
password = os.getenv("TABLEAU_PASSWORD")
tab_server = os.getenv("TABLEAU_SERVER") + "/"
site_name = "wisemuffindev254014"

workbook_list = ["Jaffle Shop - Orders by Customer", "Jaffle Shop - Orders by Week"]
datasource_list = ["Orders (Prod)"]

# initlaise server
tableau_auth = TSC.TableauAuth(username, password, site_name)
server = TSC.Server(tab_server)

with server.auth.sign_in(tableau_auth):

    # get datasources and workbooks
    workbooks = [wb for wb in TSC.Pager(server.workbooks) if wb.name in workbook_list]
    datasources = [
        ds for ds in TSC.Pager(server.datasources) if ds.name in datasource_list
    ]
    # download datasources and workbooks
    for datasource in datasources:
        logging.info(f"ID: {datasource.id}")
        logging.info(f"ID: {datasource._id}")
        logging.info(datasource)
        server.datasources.download(
            datasource_id=datasource._id,
            filepath="./tableau/tab_downloads/datasources",
            include_extract=True,
            no_extract=None,
        )

    for workbook in workbooks:
        logging.info(f"ID: {workbook.id}")
        logging.info(f"ID: {workbook._id}")
        logging.info(workbook)
        server.workbooks.download(
            workbook_id=workbook._id,
            filepath="./tableau/tab_downloads/workbooks",
            include_extract=True,
            no_extract=None,
        )

