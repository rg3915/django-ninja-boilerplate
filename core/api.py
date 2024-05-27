from http import HTTPStatus

from ninja import Schema, Router

router = Router()


class StatusSchema(Schema):
    status: str


@router.get('healthcheck', response=StatusSchema)
def healthcheck(request):
    return HTTPStatus.OK, {'status': 'ok'}
