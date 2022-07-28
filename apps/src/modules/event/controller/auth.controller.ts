import { Body, Controller, Post } from '@nestjs/common';
import { Event } from '../models/event.interface';
import { EventService } from '../service/event.service';

@Controller('event')
export class EventController {
    constructor(private eventService: EventService) {}

    @Post('/create-event')
    auth(@Body() event: Event) {
        return this.eventService.createEvent(event);
    }
}
