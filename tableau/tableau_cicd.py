import os
import time
import logging
import glob

import tableauserverclient as TSC
import tableaudocumentapi as TDI

logging.basicConfig(level=logging.DEBUG)

username = os.getenv("TABLEAU_USERNAME")
password = os.getenv("TABLEAU_PASSWORD")
tab_server = os.getenv("TABLEAU_SERVER") + "/"
site_name = "wisemuffindev254014"
project_id = "b599e7e1-d59d-4690-9912-d9b23941d25c"
database = "DBT_FUNDAMENTALS_PROD_CLONE"

workbook_list = ["Jaffle Shop - Orders by Customer", "Jaffle Shop - Orders by Week"]
datasource_list = ["Orders (Prod)"]
tableau_file_location = "./tableau/tab_downloads"
pre_fix = "uat_"

# initlaise server
tableau_auth = TSC.TableauAuth(username, password, site_name)
server = TSC.Server(tab_server)


# clear out existing files
files = glob.glob(f"{tableau_file_location}/datasources/*")
for f in files:
    os.remove(f)
files = glob.glob(f"{tableau_file_location}/workbooks/*")
for f in files:
    os.remove(f)


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
            filepath=f"{tableau_file_location}/datasources",
            include_extract=True,
            no_extract=None,
        )

    for workbook in workbooks:
        logging.info(f"ID: {workbook.id}")
        logging.info(f"ID: {workbook._id}")
        logging.info(workbook)
        server.workbooks.download(
            workbook_id=workbook._id,
            filepath=f"{tableau_file_location}/workbooks",
            include_extract=True,
            no_extract=None,
        )

    # TODO Update datasource and workbook connections to be based on PR

    for tds in os.listdir(f"{tableau_file_location}/datasources/"):
        sourceTDS = TDI.Datasource.from_file(
            f"{tableau_file_location}/datasources/{tds}"
        )
        connections = sourceTDS.connections
        connections[0].dbname = database
        # connections[0]._connectionXML.attrib["schema"] = "PR_1613809579" # cant update schema
        sourceTDS.save_as(f"{tableau_file_location}/datasources/{pre_fix}{tds}")

        # TODO Publish datasource and workbooks
        datasource_item = TSC.DatasourceItem(name=pre_fix + tds, project_id=project_id)
        server.datasources.publish(
            datasource_item,
            f"./tableau/tab_downloads/datasources/{pre_fix}{tds}",
            "Overwrite",
            connection_credentials=None,
        )

