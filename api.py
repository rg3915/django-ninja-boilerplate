from ninja import NinjaAPI

api = NinjaAPI()


api.add_router('', '{PROJECT}.core.api.router')
api.add_router('crm/', '{PROJECT}.cartorio.api.router')
