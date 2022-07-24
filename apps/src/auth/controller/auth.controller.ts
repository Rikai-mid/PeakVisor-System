import { Body, Controller, Post } from '@nestjs/common';
import { User } from '../models/user.interface';
import { AuthService } from '../service/auth.service';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @Post('/create-user')
    auth(@Body() user: User) {
        return this.authService.createUser(user);
    }
}
