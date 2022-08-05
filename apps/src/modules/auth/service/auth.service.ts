import { HttpService, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserEntity } from '../models/user.entity';
// import {PointEntity} from '../../event/models/point.entity';
// import {SkillScoreEntity} from '../../user/models/skill-score.entity';
// import {LoginManagementEntity} from '../models/loginManagement.entity';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(UserEntity)
        private readonly userRepository: Repository<UserEntity>,
        // @InjectRepository(PointEntity)
        // private readonly pointRepository: Repository<PointEntity>,
        // @InjectRepository(SkillScoreEntity)
        // private readonly skillScoreManagementRepository: Repository<SkillScoreEntity>,
        // @InjectRepository(LoginManagementEntity)
        // private readonly loginManagementRepository: Repository<LoginManagementEntity>,
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

        const rs = await this.httpService.post(url).toPromise();
        const checkWixAuthResult = rs.data.body;
        const accessToken = this.createAccessToken();

        if (!checkWixAuthResult.monthlyPaymentStatus) {
             return {
                message: 'MSG0002',
             };
        }

        if (!checkWixAuthResult.authResult) {
            return {
                message: 'MSG001',
            };
        }
        const user = this.getUserByWixId(checkWixAuthResult.wixUserId);
        const results = {
            message: '1000',
        };

        if (!user) {
            const userCreated = this.userRepository.save({
                user_id: email,
                wix_user_id: checkWixAuthResult.wixUserId,
                full_name: '',
                prefeature_id: '',
            });
            //      @todo add new record to table point
            // await  this.pointRepository.save({});
            //      @todo create new record to skill_score_management
            // await  this.skillScoreManagementRepository.save({});

            return {
                code: 1000,
                user: {...results, ...userCreated },
            };
        }
        //      @todo add new record to table login_management
        // const userLoginManagement = await  this.loginManagementRepository.save({});
        return {
            code: 1000,
            // user: { ...results, ...userLoginManagement },
        };
    }

        getUserByWixId(wixId: string) {
            return this.userRepository.findOneBy({ wix_user_id : wixId });
        }

        createAccessToken() {
            return '36 string character';
        }
}
