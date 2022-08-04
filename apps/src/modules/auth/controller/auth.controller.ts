import {Body, Controller, Get, Header, Post} from '@nestjs/common';
import { Login, User } from '../models/user.interface';
import { AuthService } from '../service/auth.service';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @Post('/login')
    login(@Body() loginParams: any) {
        return this.authService.checkAuthByWixApi(loginParams);
    }

    @Get('/test')
    test() {
        return this.authService.test();
    }
}
