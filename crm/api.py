from ninja.pagination import paginate
from http import HTTPStatus
from django.shortcuts import get_object_or_404

from ninja import Router

from .models import Person
from .schemas import PersonSchema, PersonCreateSchema


router = Router(tags=['Pessoas'])


@router.get('persons', response=list[PersonSchema])
@paginate
def list_person(request):
    return Person.objects.all()


@router.get('persons/{pk}', response=PersonSchema)
def get_person(request, pk: int):
    return get_object_or_404(Person, pk=pk)


@router.post('persons', response={HTTPStatus.CREATED: PersonSchema})
def create_person(request, payload: PersonCreateSchema):
    data = payload.dict()
    return Person.objects.create(**data)


@router.put('persons/{pk}', response=PersonSchema)
def update_person(request, pk: int, payload: PersonCreateSchema):
    instance = get_object_or_404(Person, pk=pk)
    data = payload.dict()

    for attr, value in data.items():
        setattr(instance, attr, value)

    instance.save()
    return instance


@router.delete('persons/{pk}', response={HTTPStatus.NO_CONTENT: None})
def delete_person(request, pk: int):
    instance = get_object_or_404(Person, pk=pk)
    instance.delete()
    return HTTPStatus.NO_CONTENT, None
