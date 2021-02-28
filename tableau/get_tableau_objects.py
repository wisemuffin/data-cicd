import os
import requests

username = os.getenv("TABLEAU_USERNAME")
password = os.getenv("TABLEAU_PASSWORD")
site_id = "fd1b193d-6012-4c91-8054-50c3d6c666a3"
api = os.getenv("TABLEAU_API")

# get token
def get_token() -> str:
    """gets the token for tableau server"""
    url = f"{api}/auth/signin"
    payload = f'<tsRequest>\r\n    <credentials name="{username}" password="{password}">\r\n        <site contentUrl="wisemuffindev254014"/>\r\n    </credentials>\r\n</tsRequest>'
    headers = {"Accept": "application/json", "Content-Type": "application/xml"}

    response = requests.request("POST", url, headers=headers, data=payload)
    data = response.json()
    token = data["credentials"]["token"]

    print(response.text)

    return token


def get_datasources() -> [object]:
    """returns a list of tableau datasource objects
    
    output =
    [
        {"id": "String",
        "name": "String",
        "contentUrl": "String"
        }
    ]
    """

    url = f"{api}/sites/{site_id}/datasources"
    payload = {}
    headers = {"x-tableau-auth": token, "Accept": "application/json"}

    response = requests.request("GET", url, headers=headers, data=payload)
    data = response.json()
    datasources = data["datasources"]["datasource"]

    return datasources


def get_datasource_by_id(id: str):
    """given a id will fetch a tableau datasource
    """
    url = f"{api}/sites/{site_id}/datasources/{id}/content"
    payload = {}
    headers = {
        "x-tableau-auth": token,
        "Content-Type": "application/octet-stream",
    }

    response = requests.request("GET", url, headers=headers, data=payload)

    print(response.text)


def filter_datasource(datasources_tableau: list, datasources_cicd: list) -> object:
    """filters a list of tableau datasource objects based a on a list of data source names

    datasources_tableau = [
        {
            "id": "String",
            "name": "String",
            "contentUrl": "String"
        }
    ]

    datasources_cicd = [String]
    """

    datasources_tableau_filtered = []
    for datasource in datasources_tableau:
        if datasource["name"] in datasources_cicd:
            datasources_tableau_filtered.append(datasource)
    return datasources_tableau_filtered


def get_workbooks():
    """
    workbooks_tableau = [
        {
            "id": "String",
            "name": "String",
            "contentUrl": "String"
        }
    ]
    """

    url = f"{api}/sites/{site_id}/workbooks"
    payload = {}
    headers = {"x-tableau-auth": token, "Accept": "application/json"}

    response = requests.request("GET", url, headers=headers, data=payload)
    data = response.json()
    workbooks = data["workbooks"]["workbook"]
    return workbooks


def filter_workbooks(workbooks_tableau: list, workbooks_cicd: list) -> object:
    """filters a list of tableau datasource objects based a on a list of data source names

    workbooks_tableau = [
        {
            "id": "String",
            "name": "String",
            "contentUrl": "String"
        }
    ]

    workbooks_cicd = [String]
    """

    workbooks_tableau_filtered = []
    for workbook in workbooks_tableau:
        if workbook["name"] in workbooks_cicd:
            workbooks_tableau_filtered.append(workbook)
    return workbooks_tableau_filtered


def get_workbook_by_id(id: str):
    """given a id will fetch a tableau workbook
    """

    url = f"{api}/sites/{site_id}/workbooks/{id}"
    payload = {}
    headers = {
        "x-tableau-auth": token,
        "Content-Type": "application/octet-stream",
    }

    response = requests.request("GET", url, headers=headers, data=payload)

    print(response.text)


token = get_token()
datasources_tableau = get_datasources()
datasources_cicd = ["FCT_ORDERS + FCT_CASE (DGRIFFITHS) relationships"]
datasources_filtered = filter_datasource(datasources_tableau, datasources_cicd)
for datasource in datasources_filtered:
    get_datasource_by_id(datasource["id"])

workbooks_tableau = get_workbooks()
workbooks_cicd = ["Relationships vs Joins"]
workbooks_filterd = filter_workbooks(workbooks_tableau, workbooks_cicd)
for workbook in workbooks_filterd:
    get_workbook_by_id(workbook["id"])
