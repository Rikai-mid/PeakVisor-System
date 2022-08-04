import { HttpService, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserEntity } from '../models/user.entity';
import cryptoRandomString from 'crypto-random-string';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(UserEntity)
        private readonly userRepository: Repository<UserEntity>,
        private readonly httpService: HttpService,
    ) {}

    async test() {
        const url = 'https://jsonplaceholder.typicode.com/posts/1/comments';
        const rs = await this.httpService.get(url).toPromise();
        return rs.data;
    }

    async checkAuthByWixApi(body: any) {
        const {email, password } = body;
        const url = `https://qdee8vinw0.execute-api.ap-northeast-1.amazonaws.com/dev/loginauth` +
            `?mail=${email}&pass=${password}`;

        const checkWixAuth = await this.httpService.post(url).toPromise();
        const checkWixAuthResult = checkWixAuth.data.body;
        const accessToken = this.createAccessToken();

        if (!checkWixAuthResult.authReulst) {
            return {
                message: 'MSG001',
            };
        }

        if (!checkWixAuthResult.monthlyPaymentStatus) {
            return {
                message: 'MSG0002',
            };
        }
        const user = this.getUserByWixId(checkWixAuthResult.wixUserId);
        const results = {
            message: '1000',
        };

        if (!user) {
            //      @todo add new user to table users
            const userCreated = await  this.createUser({});
            //      @todo add new record to point
            //      @todo create new record to skill_score_management

            return {...results, ...userCreated };
        }
        //      @todo add new record to login_management
        const userLoginManagement = await  this.createUserLoginManagement({});
        return { ...results, ...userLoginManagement };
    }

    async createUser(userInfo: any) {
       return this.userRepository.save(userInfo);
    }

    async createUserLoginManagement(userInfo: any) {
       return this.userRepository.save(userInfo);
    }

    getUserByWixId(wixId: string) {
        return this.userRepository.findOneBy({ wix_user_id : wixId });
    }

    createAccessToken() {
        return cryptoRandomString({ length: 36 });
    }
}
