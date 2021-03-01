import os
import time
import logging

import tableauserverclient as TSC

logging.basicConfig(level=logging.DEBUG)

username = os.getenv("TABLEAU_USERNAME")
password = os.getenv("TABLEAU_PASSWORD")
tab_server = os.getenv("TABLEAU_SERVER") + "/"
site_name = "wisemuffindev254014"

tableau_auth = TSC.TableauAuth(username, password, site_name)
server = TSC.Server(tab_server)


def get_datasources(datasource_list: [str]) -> [object]:
    """returns a list of tableau datasource objects

    output =
    [
        {"id": "String",
        "name": "String",
        "contentUrl": "String"
        }
    ]
    """

    with server.auth.sign_in(tableau_auth):
        return [
            ds for ds in TSC.Pager(server.datasources) if ds.name in datasource_list
        ]


def get_workbooks(workbook_list: [str]) -> [object]:
    """returns a list of tableau workbook objects
    workbooks_tableau = [
        {
            "id": "String",
            "name": "String",
            "contentUrl": "String"
        }
    ]
    """

    with server.auth.sign_in(tableau_auth):
        return [wb for wb in TSC.Pager(server.workbooks) if wb.name in workbook_list]


workbooks = get_workbooks(
    ["Jaffle Shop - Orders by Customer", "Jaffle Shop - Orders by Week"]
)

datasources = get_datasources(["Orders (Prod)"])


with server.auth.sign_in(tableau_auth):

    workbook_id = workbooks[0].id
    logging.info(workbook_id)
    workbook_info = server.workbooks.get_by_id(workbook_id)
    logging.info(workbook_info)
    # workbooks.publish(workbook_item, file_path, publish_mode)

