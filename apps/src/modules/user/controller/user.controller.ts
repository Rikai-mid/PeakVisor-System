import { Body, Controller, Post } from '@nestjs/common';
import { UserProgressHistory } from '../models/user-history.interface';
import { UserService } from '../service/user.service';

@Controller('user')
export class UserController {
    constructor(private userService: UserService) {}

    @Post('/create-user')
    auth(@Body() user: UserProgressHistory) {
        return this.userService.createUserHistory(user);
    }
}
