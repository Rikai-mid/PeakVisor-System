import { Body, Controller, Post } from '@nestjs/common';
import { UserProgressHistory } from '../models/user-history.interface';
import { EventService } from '../service/event.service';

@Controller('user')
export class UserController {
    constructor(private eventService: EventService) {}

    @Post('/create-user')
    auth(@Body() event: UserProgressHistory) {
        return this.eventService.createUserHistory(event);
    }
}
